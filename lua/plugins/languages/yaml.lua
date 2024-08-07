local L = require("util.new_lang")

return {
  L.treesitter({
    "yaml",
  }),

  L.mason({
    "yamlls",
    "yamlfmt",
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
}
