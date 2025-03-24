---@diagnostic disable: missing-fields, unused-local

---@module "snacks"

local constants = require("peter.constants")
local paths = constants.paths
local picker = require("peter.util.snacks.picker")

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

  preview = picker.preview.file,

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
      { "<leader>fF", picker.file.all_files, desc = "All Files" },
      { "<leader>fr", pick("recent"), desc = "Recent" },
      { "<leader>fb", pick("buffers"), desc = "Buffers" },

      -- search
      { "<leader>sb", pick("lines"), desc = "Buffer Lines" },
      { "<leader>sB", pick("grep_buffers"), desc = "Grep Open Buffers" },
      { "<leader>sg", pick("grep"), desc = "Grep" },
      { "<leader>sk", pick("keymaps"), desc = "Keymaps" },
      { "<leader>ss", picker.search.lsp_symbols, desc = "LSP Symbols" },

      { "<leader>uC", picker.neovim.colorschemes, desc = "Colorschemes" },

      -- neovim pickers
      { "<leader>nf", picker.neovim.config_files, desc = "Config" },
      { "<leader>np", picker.neovim.plugins, desc = "Plugins" },
      { "<leader>nl", picker.neovim.languages, desc = "Languages" },
    },
  },
}
