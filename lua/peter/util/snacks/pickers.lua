---@diagnostic disable: unused-local

local constants = require("peter.constants")
local files = require("peter.util.files")

local paths = constants.paths

---@module "snacks"

local pick = require("snacks").picker.pick

---@class PeterSnacksPickers
---@field neovim_language_picker fun() Find language files in neovim config
---@field neovim_plugin_picker fun() Find plugin files in neovim config
---@field colorscheme_picker fun()

---@class PeterSnacksPickers
---Custom snacks pickers.
local M = {}

---This displays a list of configured languages to choose from.
---The `.lua` extensions have been removed to make searching clearer.
M.neovim_language_picker = function()
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

M.neovim_plugin_picker = function()
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

M.colorscheme_picker = function()
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
