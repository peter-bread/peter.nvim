---@module "conform"

-- See 'https://yaml.org/'.

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "yamlls" },

  plugins = {
    L.treesitter({ "yaml" }),
    L.mason({ "yamlls", "yamlfmt", "actionlint" }),
    L.format({ yaml = { "yamlfmt" } }),
    L.lint({ yaml = { "actionlint" } }),
  },
}
