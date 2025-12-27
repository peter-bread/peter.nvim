---@module "lazy"
---@module "which-key"

-- Show available keymaps in a popup as you type.
-- See 'https://github.com/folke/which-key.nvim'.

-- TODO: Finish `opts`.

---@type LazyPluginSpec[]
return {
  {
    "folke/which-key.nvim",
    dependencies = { "peter-bread/3rd-party.nvim" },
    event = "VeryLazy",
    opts_extend = { "spec" },

    ---@type wk.Opts
    opts = {
      preset = "modern",
      win = { border = "none" },
      replace = {
        key = {
          function(key)
            return require("thirdparty.which-key").format(key)
          end,
        },
      },
      icons = { mappings = false },
      spec = {
        {
          mode = { "n", "v" },

          -- Descriptions.
          { "f", desc = "Find next {char}" },
          { "F", desc = "Find prev {char}" },
          { "t", desc = "Till next {char}" },
          { "T", desc = "Till prev {char}" },
          { "q", desc = "Record macro" },
          { "gx", desc = "Open file/link with system handler" },

          -- Groups.
          { "g", group = "goto" },
          { "z", group = "fold" },
          { "]", group = "next" },
          { "[", group = "prev" },
          { "<leader>", group = "leader" },
          { "<localleader>", group = "local leader" },
        },
      },
    },
  },
}
