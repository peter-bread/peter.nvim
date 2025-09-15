---@module "conform"

local L = require("peter.util.plugins.languages")

-- TODO: StyLua now has an LSP mode. Investigate.

---@type peter.lang.config
return {
  lsp = { "lua_ls" },

  plugins = {
    L.treesitter({ "lua", "luadoc" }),
    L.mason({ "lua_ls", "stylua" }),
    L.format({ lua = { "stylua" } }),
  },
}
