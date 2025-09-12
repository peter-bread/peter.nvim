---@module "conform"

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "yamlls" },

  plugins = {
    L.treesitter({ "yaml" }),
    L.mason({ "yamlls", "yamlfmt" }), -- TODO: Add 'actionlint' (requires 'nvim-lint')?
    L.format({ yaml = { "yamlfmt" } }),
  },
}
