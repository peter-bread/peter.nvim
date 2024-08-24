local L = require("util.new_lang")

return {
  L.treesitter({
    "bash",
  }),

  L.mason({
    "bashls", -- lsp
    "shellcheck", -- linter (used by lsp so nvim-lint not needed)
    "shellharden", -- formatter
    "shfmt", -- formatter
    "bash-debug-adapter", -- dap
  }),

  L.lspconfig({
    servers = {
      bashls = {
        filetypes = { "sh", "zsh" },
      },
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      sh = { "shfmt", "shellharden" },
      zsh = { "shfmt", "shellharden" },
    },
  }),
}
