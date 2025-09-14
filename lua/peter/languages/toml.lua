local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "taplo" },

  plugins = {
    L.treesitter({ "toml" }),
    L.mason({ "taplo" }),
    L.format({ toml = { "taplo" } }),
  },
}
