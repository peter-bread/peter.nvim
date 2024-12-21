local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "luau",
  }),

  L.mason({
    "luau_lsp",
    "stylua",
    "selene",
  }),

  L.lspconfig({
    servers = {
      luau_lsp = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      luau = { "stylua" },
    },
  }),

  L.lint({
    linters_by_ft = {
      luau = { "selene" },
    },
  }),
}
