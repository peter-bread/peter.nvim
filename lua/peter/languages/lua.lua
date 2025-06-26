local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "lua_ls" },

  plugins = {
    L.treesitter({ "lua", "luadoc" }),
    L.mason({ "lua_ls", "stylua" }),
    L.format({ lua = { "stylua" } }),
  },
}
