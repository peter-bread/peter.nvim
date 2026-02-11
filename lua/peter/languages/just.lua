-- See 'https://just.systems/man/en/'.

---@type peter.lang.Config
return {
  lsp = { "just" },

  plugins = {
    treesitter = { "just" },
    mason = { "just" },
  },
}
