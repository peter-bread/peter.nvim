local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "zig",
  }),

  L.mason2({
    "zls",
  }),

  L.lspconfig({
    servers = {
      zls = {},
    },
  }),

  L.format({
    formatters_by_ft = {
      zig = { "zigfmt" },
    },
  }),
}
