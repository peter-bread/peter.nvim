local L = require("util.new_lang")

return {
  L.treesitter({
    "lua",
    "luadoc",
    "luau",
    "luap",
  }),

  L.mason({
    "lua_ls", -- lsp
    "stylua", -- formatter
    "selene", -- linter
  }),

  L.lspconfig({
    servers = {
      lua_ls = {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if
            vim.loop.fs_stat(path .. "/.luarc.json")
            or vim.loop.fs_stat(path .. "/.luarc.jsonc")
          then
            return
          end
          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              diagnostics = {
                globals = {
                  "vim",
                },
              },
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            })
        end,
        settings = {
          Lua = {},
        },
      },
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      lua = { "stylua" },
    },
  }),

  L.lint({
    linters_by_ft = {
      lua = { "selene" },
    },
  }),
  -- any extra go plugins here...
}
