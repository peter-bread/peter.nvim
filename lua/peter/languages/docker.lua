---@type peter.lang.Config
return {
  lsp = { "dockerls" },

  plugins = {
    treesitter = { "dockerfile" },
    mason = { "dockerls" },
  },
}
