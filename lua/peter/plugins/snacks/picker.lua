---@diagnostic disable: missing-fields, unused-local

---@module "snacks"

---@type snacks.picker.Config
local Config = {
  enabled = true,
  layout = {
    preset = "my_telescope",
  },
  -- TODO: use delta for git diff
  -- previewers = {
  --   diff = {
  --     builtin = false,
  --     cmd = { "delta" },
  --   },
  --   git = {
  --     builtin = false,
  --     native = true,
  --   },
  -- },
  --

  preview = function(ctx)
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
    if
      ctx.item.buf
      and vim.uri_from_bufnr(ctx.item.buf):sub(1, 4) ~= "file"
    then
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
        local max_size = ctx.picker.opts.previewers.file.max_size
          or (1024 * 1024)
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
  end,

  win = {
    preview = {
      wo = {
        foldcolumn = "0",
        relativenumber = false,
        signcolumn = "no",
        statuscolumn = "",
      },
    },
  },

  layouts = {
    my_telescope = {
      reverse = true,
      layout = {
        box = "horizontal",
        backdrop = false,
        width = 0.9,
        height = 0.9,
        border = "solid",
        {
          box = "vertical",
          {
            win = "list",
            title = " Results ",
            title_pos = "center",
            border = "solid",
          },
          {
            win = "input",
            height = 1,
            border = "solid",
            title = "{title} {live} {flags}",
            title_pos = "center",
          },
        },
        {
          win = "preview",
          title = "{preview:Preview}",
          width = 0.55,
          border = "solid",
          title_pos = "center",
        },
      },
    },
  },
}

---Wrapper function to make config a bit cleaner
---@param source string Picker to use
---@param opts? snacks.picker.Config Picker options
---@return function
local pick = function(source, opts)
  return function()
    require("snacks").picker.pick(source, opts)
  end
end

local constants = require("peter.constants")
local paths = constants.paths

local pickers = require("peter.util.snacks.pickers")

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      picker = Config,
    },

    keys = {

      -- all
      {
        "<leader>S",
        function()
          require("snacks").picker()
        end,
        mode = "n",
        desc = "Search",
      },

      -- find
      { "<leader>ff", pick("files"), desc = "Files" },
      { "<leader>fF", pickers.file.all_files, desc = "All Files" },
      { "<leader>fr", pick("recent"), desc = "Recent" },
      { "<leader>fb", pick("buffers"), desc = "Buffers" },

      -- search
      { "<leader>sb", pick("lines"), desc = "Buffer Lines" },
      { "<leader>sB", pick("grep_buffers"), desc = "Grep Open Buffers" },
      { "<leader>sg", pick("grep"), desc = "Grep" },
      { "<leader>sk", pick("keymaps"), desc = "Keymaps" },
      { "<leader>ss", pickers.search.lsp_symbols, desc = "LSP Symbols" },

      { "<leader>uC", pickers.neovim.colorschemes, desc = "Colorschemes" },

      -- neovim pickers
      { "<leader>nf", pickers.neovim.config_files, desc = "Config" },
      { "<leader>np", pickers.neovim.plugins, desc = "Plugins" },
      { "<leader>nl", pickers.neovim.languages, desc = "Languages" },
    },
  },
}
