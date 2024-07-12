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
      ["<leader>g"] = { name = "git" },
      ["<leader>gh"] = { name = "hunks", ["_"] = "which_key_ignore" },
      ["<leader>u"] = { name = "ui" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
