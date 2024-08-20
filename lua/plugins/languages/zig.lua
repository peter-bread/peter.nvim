local L = require("util.new_lang")

return {
  L.treesitter({
    "zig",
  }),

  L.mason({
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
