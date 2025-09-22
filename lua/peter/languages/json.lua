---@module "conform"

-- See 'https://www.json.org/json-en.html'.

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "jsonls" },

  plugins = {
    L.treesitter({ "json", "jsonc", "json5" }),
    L.mason({ "jsonls", "prettier" }),
    L.format({ json = { "prettier" } }),
  },
}
