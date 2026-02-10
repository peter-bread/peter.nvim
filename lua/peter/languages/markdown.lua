-- See 'https://daringfireball.net/projects/markdown/'.

---@type peter.lang.Config
return {
  lsp = { "marksman" },

  plugins = {
    treesitter = { "markdown", "markdown_inline", "html" },
    mason = {
      "marksman", -- LSP.
      "prettier", -- Formatter.
    },
    format = { markdown = { "prettier" } },
  },
}
