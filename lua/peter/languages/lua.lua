-- See 'https://www.lua.org/'.

---@type peter.lang.Config
return {
  -- lsp = { "lua_ls" },
  lsp = { "emmylua_ls" },

  plugins = {
    treesitter = { "lua", "luadoc" },

    -- HACK: Pin Lua Language Server to 3.16.4.
    -- See 'https://github.com/folke/lazydev.nvim/issues/136'.
    --
    -- Alternate solution, in LSP config:
    -- settings = {
    --   Lua = {
    --     workspace = {
    --       library = vim.api.nvim_get_runtime_file("", true),
    --     },
    --   },
    -- }
    mason = { { "lua_ls", version = "3.16.4" }, "stylua", "selene" },
    format = { lua = { "stylua" } },
    lint = { lua = { "selene" } },
  },
}
