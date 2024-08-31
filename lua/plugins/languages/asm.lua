local L = require("util.new_lang")

return {
  L.treesitter({
    "asm",
  }),

  L.mason({
    "asm-lsp",
  }),

  L.lspconfig({
    servers = {
      asm_lsp = {},
    },
  }),
}
