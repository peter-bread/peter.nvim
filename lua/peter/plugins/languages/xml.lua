local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "xml",
  }),

  L.mason2({
    "lemminx",
  }),

  L.lspconfig({
    servers = {
      lemminx = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      xml = { lsp_format = "prefer" },
    },
  }),
}
