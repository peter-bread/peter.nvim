---@type peter.lang.Config
return {
  lsp = { "clangd" },
  plugins = {
    mason = { "clangd" },
    format = { c = { lsp_format = "prefer" } },
  },
}
