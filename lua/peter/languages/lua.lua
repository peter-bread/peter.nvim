-- See 'https://www.lua.org/'.

---@type peter.lang.Config
return {
  lsp = { "lua_ls" },

  plugins = {
    treesitter = { "lua", "luadoc" },
    mason = { "lua_ls", "stylua", "selene" },
    format = { lua = { "stylua" } },
    lint = { lua = { "selene" } },
  },
}
