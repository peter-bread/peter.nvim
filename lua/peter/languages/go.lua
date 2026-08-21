-- See 'https://go.dev/'.

---@type peter.lang.Config
return {
  lsp = { "gopls" },

  plugins = {
    treesitter = { "go", "gomod", "gosum", "gowork", "gotmpl" },
    mason = { "gopls", "goimports" },
    format = { go = { "goimports", lsp_format = "last" } },
  },
}
