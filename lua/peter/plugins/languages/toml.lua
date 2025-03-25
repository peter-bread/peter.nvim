local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "toml",
  }),

  L.mason2({
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
