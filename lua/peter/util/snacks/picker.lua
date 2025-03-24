---@diagnostic disable: unused-local

local constants = require("peter.constants")
local files = require("peter.util.files")

local paths = constants.paths

---@module "snacks"

local pick = require("snacks").picker.pick

---@class PeterSnacksPickers
---@field file PeterSnacksFilePickers
---@field search PeterSnacksSearchPickers
---@field neovim PeterSnacksNeovimPickers
---@field preview PeterSnacksPreviewers
---Custom snacks picker functions (mainly pickers).
local M = {}

---@class PeterSnacksFilePickers
---@field all_files fun()
M.file = {}

---@class PeterSnacksSearchPickers
---@field lsp_symbols fun()
M.search = {}

---@class PeterSnacksNeovimPickers
---@field config_files fun()
---@field languages fun()
---@field plugins fun()
---@field colorschemes fun()
---Custom neovim snacks pickers
M.neovim = {}

---@class PeterSnacksPreviewers
---@field file fun(ctx: snacks.picker.preview.ctx): boolean|nil
M.preview = {}

M.file.all_files = function()
  pick("files", { hidden = true, ignored = true })
end

M.search.lsp_symbols = function()
  pick("lsp_symbols", { tree = false })
end

M.neovim.config_files = function()
  pick("files", { cwd = paths.config })
end

---This displays a list of configured languages to choose from.
---The `.lua` extensions have been removed to make searching clearer.
M.neovim.languages = function()
  pick("files", {
    title = "Languages",
    cwd = paths.languages,
    layout = function(source)
      ---@type snacks.picker.layout.Config
      return {
        preset = "select",
        layout = {
          width = 0.2,
          height = 0.65,
          min_width = 30,
          border = "solid",
        },
      }
    end,

    ---@return snacks.picker.finder.Item
    transform = function(item, ctx)
      -- don't use extensions when matching
      item.text = files.strip_extension(item.text, "lua")
      return item
    end,

    format = function(item, picker)
      return {
        -- don't show extensions in item list
        { files.strip_extension(item.file, "lua"), "SnacksPickerFile" },
      }
    end,
  })
end

M.neovim.plugins = function()
  pick("files", {
    title = "Plugins",
    cwd = paths.plugins,

    ---@return snacks.picker.finder.Item
    transform = function(item, ctx)
      -- don't use extensions when matching
      item.text = files.strip_extension(item.text, "lua")
      return item
    end,

    format = function(item, picker)
      return {
        -- don't show extensions in item list
        { files.strip_extension(item.file, "lua") },
      }
    end,
  })
end

M.neovim.colorschemes = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local n = vim.api.nvim_buf_get_name(bufnr)
  pick("colorschemes", {
    preview = function(ctx)
      -- attempt to show current file in preview
      if n ~= "" then
        ctx.item.file = n
      end
      if not ctx.preview.state.colorscheme then
        ctx.preview.state.colorscheme = vim.g.colors_name or "default"
        ctx.preview.state.background = vim.o.background
        ctx.preview.win:on("WinClosed", function()
          vim.schedule(function()
            if not ctx.preview.state.colorscheme then
              return
            end
            vim.cmd("colorscheme " .. ctx.preview.state.colorscheme)
            vim.o.background = ctx.preview.state.background
          end)
        end, { win = true })
      end
      vim.schedule(function()
        vim.cmd("colorscheme " .. ctx.item.text)
      end)
      require("snacks").picker.preview.file(ctx)
    end,
  })
end

M.preview.file = function(ctx)
  local uv = vim.uv or vim.loop
  local preview = require("snacks.picker.preview")

  local patterns = require("peter.util.patterns")
  local get_sensitive_message = patterns.get_sensitive_message

  if
    ctx.item.buf
    and not ctx.item.file
    and not vim.api.nvim_buf_is_valid(ctx.item.buf)
  then
    ctx.preview:notify("Buffer no longer exists", "error")
    return
  end

  -- used by some LSP servers that load buffers with custom URIs
  if ctx.item.buf and vim.uri_from_bufnr(ctx.item.buf):sub(1, 4) ~= "file" then
    vim.fn.bufload(ctx.item.buf)
  elseif ctx.item.file and ctx.item.file:find("^%w+://") then
    ctx.item.buf = vim.fn.bufadd(ctx.item.file)
    vim.fn.bufload(ctx.item.buf)
  end

  if ctx.item.buf and vim.api.nvim_buf_is_loaded(ctx.item.buf) then
    local name = vim.api.nvim_buf_get_name(ctx.item.buf)
    name = uv.fs_stat(name) and vim.fn.fnamemodify(name, ":t") or name
    ctx.preview:set_title(name)
    ctx.preview:set_buf(ctx.item.buf)
  else
    local path = Snacks.picker.util.path(ctx.item)
    if not path then
      ctx.preview:notify("Item has no `file`", "error")
      return
    end

    if Snacks.image.supports_file(path) then
      return preview.image(ctx)
    end

    -- re-use existing preview when path is the same
    if path ~= Snacks.picker.util.path(ctx.prev) then
      ctx.preview:reset()
      vim.bo[ctx.buf].buftype = ""

      local name = vim.fn.fnamemodify(path, ":t")
      ctx.preview:set_title(ctx.item.title or name)

      local stat = uv.fs_stat(path)
      if not stat then
        ctx.preview:notify("file not found: " .. path, "error")
        return false
      end
      if stat.type == "directory" then
        return preview.directory(ctx)
      end
      local max_size = ctx.picker.opts.previewers.file.max_size or (1024 * 1024)
      if stat.size > max_size then
        ctx.preview:notify("large file > 1MB", "warn")
        return false
      end
      if stat.size == 0 then
        ctx.preview:notify("empty file", "warn")
        return false
      end

      local file = assert(io.open(path, "r"))

      local is_binary = false
      local ft = ctx.picker.opts.previewers.file.ft
        or vim.filetype.match({ filename = path })
      if ft == "bigfile" then
        ft = nil
      end
      local lines = {}
      for line in file:lines() do
        ---@cast line string
        if #line > ctx.picker.opts.previewers.file.max_line_length then
          line = line:sub(1, ctx.picker.opts.previewers.file.max_line_length)
            .. "..."
        end
        -- Check for binary data in the current line
        if line:find("[%z\1-\8\11\12\14-\31]") then
          is_binary = true
          if not ft then
            ctx.preview:notify("binary file", "warn")
            return
          end
        end
        table.insert(lines, line)
      end

      file:close()

      if is_binary then
        ctx.preview:wo({
          number = false,
          relativenumber = false,
          cursorline = false,
          signcolumn = "no",
        })
      end

      -- NOTE: custom logic to not show sensitive files

      ft = ctx.picker.opts.previewers.file.ft

      if vim.g.private_mode_enabled then
        local message = get_sensitive_message(path)
        if message then
          lines = { message }
          ctx.preview:wo({
            number = false,
            relativenumber = false,
            cursorline = false,
            foldcolumn = "0",
            signcolumn = "no",
            statuscolumn = "",
          })
          ft = "text"
        end
      end

      ctx.preview:set_lines(lines)

      ctx.preview:highlight({
        file = path,
        ft = ft,
        buf = ctx.buf,
      })
    end
  end
  ctx.preview:loc()
end

return M
