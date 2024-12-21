local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "dockerfile",
  }),

  L.mason({
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
