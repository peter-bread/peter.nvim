-- show available keymaps in a popup as you type
-- https://github.com/folke/which-key.nvim

-- TODO: finish `opts`

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    ---@type wk.Opts
    opts = {
      preset = "modern",
      win = { border = "none" },
      icons = { mappings = false },
      spec = {
        {
          mode = { "n", "v" },

          -- descriptions
          { "f", desc = "Find next {char}" },
          { "F", desc = "Find prev {char}" },
          { "t", desc = "Till next {char}" },
          { "T", desc = "Till prev {char}" },
          { "q", desc = "Record macro" },
          { "gx", desc = "Open file/link with system handler" },

          -- groups
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
