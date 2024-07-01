return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.register({
      ["<leader>f"] = {
        name = "find",
      }
    })
  end,
}
