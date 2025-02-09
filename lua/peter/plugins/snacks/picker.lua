---@diagnostic disable: missing-fields

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
        border = "none",
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
          width = 0.45,
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

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      picker = Config,
    },

    keys = {
      { "<leader>ff", pick("files"), desc = "Find Files" },
      { "<leader>fr", pick("recent"), desc = "Recent Files" },
    },
  },
}
