local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "bash",
  }),

  L.mason2({
    "bashls", -- lsp
    "shellcheck", -- linter (used by lsp so nvim-lint not needed)
    "shellharden", -- formatter
    "shfmt", -- formatter
    "bash-debug-adapter", -- dap
  }),

  L.lspconfig({
    servers = {
      bashls = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      sh = { "shfmt", "shellharden" },
    },
  }),
}
