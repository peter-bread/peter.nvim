local ts = {
  "lua",
  "luadoc",
  "luau",
  "luap",
}

local mason = {
  "lua_ls", -- lsp
  "stylua", -- formatter
  "selene", -- linter
}

local nvim_lspconfig_opts = {
  servers = {
    lua_ls = {
      settings = {
        Lua = {
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
        },
      },
    },
  },
  ---@type LspCustomSetup
  setup = {
    ---@diagnostic disable-next-line: unused-local
    lua_ls = function(server, opts) end,
  },
}

---@type formatOpts
local format_opts = {
  formatters_by_ft = {
    lua = { "stylua" },
  },
}

local lint_opts = {
  -- linters_by_ft = {
  --   lua = { "selene" },
  -- },
}

local neotest_spec = {}

return require("util.languages").add_language(
  ts,
  mason,
  nvim_lspconfig_opts,
  format_opts,
  lint_opts,
  neotest_spec
)
