local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "gleam",
  }),

  L.lspconfig({
    servers = {
      gleam = {},
    },
  }),

  L.format({
    formatters_by_ft = {
      gleam = { "gleam" },
    },
  }),
}
