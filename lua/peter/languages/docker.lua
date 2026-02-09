---@type peter.lang.config
return {
  lsp = { "dockerls" },

  plugins = {
    treesitter = { "dockerfile" },
    mason = { "dockerls" },
  },
}
