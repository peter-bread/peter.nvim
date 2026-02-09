-- See 'https://www.json.org/json-en.html'.

---@type peter.lang.config
return {
  lsp = { "jsonls" },

  plugins = {
    treesitter = { "json", "json5" },
    mason = { "jsonls", "prettier" },
    format = { json = { "prettier" } },
  },
}
