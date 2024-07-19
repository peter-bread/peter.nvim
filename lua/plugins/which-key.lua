return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
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

        -- groups
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        { "]", group = "next" },
        { "[", group = "prev" },
        { "<leader>", group = "leader" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>u", group = "ui" },
      },
    },
    icons = { rules = false },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
