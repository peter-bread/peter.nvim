local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "latex",
  }),

  L.mason({
    "texlab", -- lsp
  }),

  L.lspconfig({
    servers = {
      texlab = {},
    },
  }),

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- vim.g.vimtex_ .....
    end,
  },
}
