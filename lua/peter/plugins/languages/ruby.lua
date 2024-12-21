local L = require("peter.util.new_lang")

---@alias lsp "ruby_lsp"|"solargraph"
---@alias fmt "rubocop"|"standardrb"

---@type lsp
local lsp = "ruby_lsp"

---@type fmt
local fmt = "standardrb"

-- TODO: add support for eruby

return {
  L.treesitter({
    "ruby",
  }),

  L.mason({
    lsp,
    fmt,
  }),

  L.lspconfig({
    servers = {
      [lsp] = {},
      [fmt] = {},
    },
  }),

  -- TODO: test, dap
}
