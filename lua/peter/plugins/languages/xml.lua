local L = require("peter.util.new_lang")

return {
  L.treesitter({ "xml" }),

  L.mason({ "lemminx" }),

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
