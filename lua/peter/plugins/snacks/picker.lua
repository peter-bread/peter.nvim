---@diagnostic disable: missing-fields, unused-local

---@module "snacks"

---@type snacks.picker.Config
local Config = {
  enabled = true,
  layout = {
    preset = "telescope",
  },
  layouts = {
    telescope = {
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
      -- stylua: ignore start

      -- find files
      { "<leader>ff", pick("files"), desc = "Files" },
      { "<leader>fF", pick("files", { hidden = true, ignored = true }), desc = "All Files" },
      { "<leader>fr", pick("recent"), desc = "Recent" },
      { "<leader>fb", pick("buffers"), desc = "Buffers" },

      -- search
      { "<leader>sg", pick("grep"), desc = "Grep" },

      { "<leader>uC", pickers.colorscheme_picker, desc = "Colorschemes" },

      -- neovim pickers
      { "<leader>nf", pick("files", { cwd = paths.config }), desc = "Config" },
      { "<leader>np", pickers.neovim_plugin_picker, desc = "Plugins" },
      { "<leader>nl", pickers.neovim_language_picker, desc = "Languages" },
      -- stylua: ignore end
    },
  },
}
