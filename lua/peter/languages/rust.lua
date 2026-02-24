-- See 'https://rust-lang.org/'.

---@type peter.lang.Config
return {
  lsp = { "rust_analyzer" },

  plugins = {
    format = { rust = { lsp_format = "prefer" } },
  },
}
