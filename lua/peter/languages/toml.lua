-- See 'https://toml.io/en/'.

---@type peter.lang.Config
return {
  lsp = { "taplo" },

  plugins = {
    treesitter = { "toml" },
    mason = { "taplo" },
    format = { toml = { "taplo" } },
  },
}
