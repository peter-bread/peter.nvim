local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "asm",
  }),

  L.mason2({
    "asm_lsp",
  }),

  L.lspconfig({
    servers = {
      asm_lsp = {},
    },
  }),
}
