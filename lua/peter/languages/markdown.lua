local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "marksman" },

  plugins = {
    L.treesitter({ "markdown", "markdown_inline" }),
    L.mason({
      "marksman", -- LSP.
      "prettier", -- Formatter.
    }),
    L.format({ markdown = { "prettier" } }),
  },
}
