local L = require("util.new_lang")

return {
  L.treesitter({
    "yaml",
  }),

  L.mason({
    "yamlls", -- lsp
    "yamlfmt", -- formatter
    "actionlint", -- linter for github actions
  }),

  L.lspconfig({
    servers = {
      yamlls = {
        settings = {
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            schemeStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      },
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      yaml = { "yamlfmt" },
    },
  }),

  -- linter for github actions
  L.lint({
    linters_by_ft = {
      yaml = { "actionlint" },
    },
  }),
}
