local L = require("util.new_lang")

return {
  L.treesitter({
    "javascript",
    "jsdoc",
    "typescript",
    "tsx",
  }),

  L.mason({
    "vtsls", -- lsp
    "prettier", -- formatter
    "eslint-lsp", -- lsp (formatter/linter)
  }),

  L.lspconfig({
    servers = {
      vtsls = {},
      eslint = {
        settings = {
          workingDirectories = {
            mode = { "auto" },
          },
        },
      },
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
    },
  }),
}
