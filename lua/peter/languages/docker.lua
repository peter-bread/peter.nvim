-- See 'https://www.docker.com/'.

---@type peter.lang.Config
return {
  lsp = { "dockerls" },

  plugins = {
    treesitter = { "dockerfile" },
    mason = { "dockerls" },
  },
}
