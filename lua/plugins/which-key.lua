return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.register({
      ["g"] = {
        name = "prefix",
      },
      ["gs"] = {
        name = "surround",
      },
      ["<leader>f"] = {
        name = "find",
      },
      ["<leader>u"] = {
        name = "ui",
      },
    })
  end,
}
