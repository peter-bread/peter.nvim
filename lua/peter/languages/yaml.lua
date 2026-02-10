-- See 'https://yaml.org/'.

---@type peter.lang.Config
return {
  lsp = { "yamlls" },

  plugins = {
    treesitter = { "yaml" },
    mason = { "yamlls", "yamlfmt", "actionlint" },
    format = { yaml = { "yamlfmt" } },
    lint = { yaml = { "actionlint" } },
  },
}
