return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "goto" },
      ["gs"] = { name = "surround" },
      ["z"] = { name = "fold" },
      ["]"] = { name = "next" },
      ["["] = { name = "prev" },
      ["<leader>f"] = { name = "find" },
      ["<leader>u"] = { name = "ui" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
