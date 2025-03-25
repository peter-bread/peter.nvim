local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "dockerfile",
  }),

  L.mason2({
    "dockerls", -- lsp
    "docker_compose_language_service", -- lsp
    "hadolint", -- linter
  }),

  L.lspconfig({
    servers = {
      dockerls = {},
      docker_compose_language_service = {},
    },
  }),

  L.lint({
    linters_by_ft = {
      dockerfile = { "hadolint" },
    },
  }),
}
