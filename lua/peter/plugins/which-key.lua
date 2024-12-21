---@diagnostic disable: missing-fields

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    ---@type wk.Opts
    opts = {
      preset = "modern",
      win = {
        border = "none",
      },
      spec = {
        {
          mode = { "n", "v" },

          -- descriptions
          { "f", desc = "Find {char}" },
          { "F", desc = "Find back {char}" },
          { "t", desc = "Til {char}" },
          { "T", desc = "Til back {char}" },
          { ";", desc = "Repeat forward" },
          { ",", desc = "Repeat backward" },

          { "gx", desc = "Open file/link with system app" },

          -- groups
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          { "]", group = "next" },
          { "[", group = "prev" },
          { "<leader>", group = "leader" },
          { "<leader>b", group = "buffers" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>n", group = "neovim" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },

          { "<localleader>", group = "local leader" },
        },
      },
      icons = { mappings = false },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
