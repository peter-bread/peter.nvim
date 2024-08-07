local L = require("util.new_lang")

return {
  L.treesitter({
    "json",
    "json5",
  }),

  L.mason({
    "jsonls", -- lsp
    "prettier", -- formatter
  }),

  L.lspconfig({
    servers = {
      jsonls = {
        settings = {
          json = {
            format = {
              enable = true,
            },
            schemas = require("schemastore").json.schemas(),
            validate = {
              enable = true,
            },
          },
        },
      },
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      json = { "prettier" },
    },
  }),
}
