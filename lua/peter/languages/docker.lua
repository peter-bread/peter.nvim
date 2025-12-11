local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "dockerls" },

  plugins = {
    L.treesitter({ "dockerfile" }),
    L.mason({ "dockerls" }),
  },
}
