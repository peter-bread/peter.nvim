local L = require("peter.util.new_lang")

-- TODO: add support for eruby

return {
  L.treesitter2({
    "ruby",
  }),

  L.mason2({
    "ruby_lsp",
    "standardrb",
  }),

  L.lspconfig({
    servers = {
      ruby_lsp = {},
      standardrb = {},
    },
  }),

  ---@module "conform"

  -- WARNING: Untested.
  -- Might be better to let lsp handle formatting???
  L.format({
    formatters_by_ft = {
      ruby = { "standardrb" },
    },
  }),

  -- TODO: dap, (test)
}
