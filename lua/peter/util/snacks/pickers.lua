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

---@class PeterSnacksFilePickers
---@field all_files fun()

---@class PeterSnacksSearchPickers
---@field lsp_symbols fun()

---@class PeterSnacksNeovimPickers
---@field config_files fun()
---@field languages fun()
---@field plugins fun()
---@field colorschemes fun()

---@class PeterSnacksPickers
---Custom snacks pickers.
local M = {}

---@class PeterSnacksFilePickers
M.file = {}

M.file.all_files = function()
  pick("files", { hidden = true, ignored = true })
end

---@class PeterSnacksSearchPickers
M.search = {}

M.search.lsp_symbols = function()
  pick("lsp_symbols", { tree = false })
end

---@class PeterSnacksNeovimPickers
---Custom neovim snacks pickers
M.neovim = {}

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
  pick("colorschemes", {
    confirm = function(picker, item, action)
      picker:close()
      if item then
        picker.preview.state.colorscheme = nil
        -- TODO: show current file instead of colorscheme file

        -- HACK: don't use `vim.schedule`
        -- This ensures lualine colours update properly
        -- vim.cmd.colorscheme(item.text)

        vim.schedule_wrap(function()
          vim.cmd.colorscheme(item.text)
        end)
      end
    end,
  })
end

return M
