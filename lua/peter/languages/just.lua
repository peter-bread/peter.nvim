local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "just" },

  plugins = {
    L.treesitter({ "just" }),
    L.mason({ "just" }),
  },
}
