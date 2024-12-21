local L = require("peter.util.new_lang")

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
        filetypes = {
          -- defaults (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls)
          "yaml",
          "yaml.docker-compose",
          "yaml.gitlab",

          -- custom
          "yaml.ghaction",
        },
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
          },
        },
        on_new_config = function(new_config, new_root_dir)
          new_config.settings.yaml.schemas = vim.tbl_deep_extend(
            "force",
            new_config.settings.yaml.schemas or {},
            require("schemastore").yaml.schemas()
          )
        end,
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
      ghaction = { "actionlint" },
    },
  }),
}
