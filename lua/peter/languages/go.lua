-- See 'https://go.dev/'.

---@type peter.lang.config
return {
  lsp = { "gopls" },

  plugins = {
    treesitter = { "go", "gomod", "gosum", "gowork", "gotmpl" },
    mason = { "gopls", "gofumpt", "goimports" },
    format = { go = { "goimports", "gofumpt" } },
  },
}
