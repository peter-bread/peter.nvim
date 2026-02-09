---@type peter.lang.config
return {
  lsp = { "clangd" },
  plugins = {
    mason = { "clangd" },
    format = { c = { lsp_format = "prefer" } },
  },
}
