-- show available keymaps in a popup as you type
-- https://github.com/folke/which-key.nvim

-- TODO: finish `opts`
-- TODO: work out how to deal with `mini.nvim` so I can get icons

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    ---@type wk.Opts
    opts = {
      preset = "modern",
      win = { border = "none" },
      spec = {},
    },
  },
}
