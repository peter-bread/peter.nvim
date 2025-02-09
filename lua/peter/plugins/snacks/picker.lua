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
  win = {
    input = {
      keys = {
        -- exit on ESC without first going to normal mode
        ["<Esc>"] = { "close", mode = { "n", "i" } },
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
      { "<leader>ff", pick("files"), desc = "Find Files" },
      { "<leader>fF", pick("files", { hidden = true, ignored = true }), desc = "Find All Files" },
      { "<leader>fr", pick("recent"), desc = "Recent Files" },
      { "<leader>fb", pick("buffers"), desc = "Find Buffers" },

      -- search
      { "<leader>sg", pick("grep"), desc = "Grep" },

      -- neovim pickers
      { "<leader>nf", pick("files", { cwd = paths.config[1] }), desc = "Config Files" },
      { "<leader>np", pick("files", { cwd = paths.plugins }), desc = "Plugins" },
      -- stylua: ignore end

      {
        "<leader>nl",
        pick("files", {
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
            local files = require("peter.util.files")
            item.text = files.strip_extension(item.text, "lua")
            return item
          end,

          format = function(item, picker)
            local files = require("peter.util.files")
            return {
              { files.strip_extension(item.file, "lua"), "SnacksPickerFile" },
            }
          end,
        }),
        desc = "Languages",
      },
    },
  },
}
