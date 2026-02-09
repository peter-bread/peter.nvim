-- See 'https://toml.io/en/'.

---@type peter.lang.config
return {
  lsp = { "taplo" },

  plugins = {
    treesitter = { "toml" },
    mason = { "taplo" },
    format = { toml = { "taplo" } },
  },
}
