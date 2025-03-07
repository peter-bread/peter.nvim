local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "asm",
  }),

  L.mason({
    "asm_lsp",
  }),

  L.lspconfig({
    servers = {
      asm_lsp = {},
    },
  }),
}
