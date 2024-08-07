local L = require("util.new_lang")

return {
  L.treesitter({
    "toml",
  }),

  L.mason({
    "taplo",
  }),

  L.lspconfig({
    servers = {
      taplo = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      toml = { "taplo" },
    },
  }),
}
