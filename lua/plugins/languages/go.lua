local L = require("util.new_lang")

return {
  L.treesitter({
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
  }),

  L.mason({
    "gopls", -- lsp
    "gofumpt", -- formatter
    "goimports", -- formatter
    "golangci-lint", -- linter
    "delve", -- dap
  }),

  L.lspconfig({
    servers = {
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = {
              "-.git",
              "-.vscode",
              "-.idea",
              "-.vscode-test",
              "-node_modules",
            },
            semanticTokens = true,
          },
        },
      },
    },
    setup = {
      ---@diagnostic disable-next-line: unused-local
      gopls = function(_, opts)
        require("util.lsp").on_attach(function(client, _)
          if not client.server_capabilities.semanticTokensProvider then
            local semantic =
              client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                ---@diagnostic disable: need-check-nil
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end, "gopls")
      end,
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
    },
  }),

  L.lint({
    linters_by_ft = {
      go = { "golangcilint" },
    },
  }),

  L.test({
    dep = "fredrikaverpil/neotest-golang",
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      adapters = {
        ["neotest-golang"] = {},
      },
    },
  }),

  L.dap({
    deps = "leoluz/nvim-dap-go",
    setup = function()
      require("dap-go").setup()
    end,
  }),
  -- any extra go plugins here...
}
