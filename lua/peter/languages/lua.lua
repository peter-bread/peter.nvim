---@module "conform"

-- See 'https://www.lua.org/'.

local L = require("peter.util.plugins.languages")

-- TODO: StyLua now has an LSP mode. Investigate.

---@type peter.lang.config
return {
  lsp = { "lua_ls" },

  plugins = {
    L.treesitter({ "lua", "luadoc" }),

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
    L.mason({ { "lua_ls", version = "3.16.4" }, "stylua", "selene" }),
    L.format({ lua = { "stylua" } }),
    L.lint({ lua = { "selene" } }),
  },
}
