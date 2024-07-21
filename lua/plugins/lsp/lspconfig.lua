---Table of custom LSP setup functions.
---Return `true` if LSP setup is complete, i.e. `require("lspconfig")[server_name].setup(server_opts)` is not needed.
---Return `false|nil` if LSP setup is not complete, i.e. extra config is done in this function but `require("lspconfig")[server_name].setup(server_opts)` still needs to be used to finish setup.
---Use ["server_name"] for server-specific setups
---Use ["*"] for fallback setup for any server that doesn't have its own custom setup
---e.g.
--- ```lua
--- setup = {
---   lua_ls = function(server, opts)
---     -- custom config
---     require("util.lsp").on_attach(...)
---     return false -- still need to use lspconfig
---   end,
---   ["*"] = function(server, opts)
---     -- maybe modify opts
---     require("lspconfig")[server].setup(opts)
---     return true -- LSP already set up
---   end,
--- },
--- ```
---@alias LspCustomSetup table<string, fun(server:string, opts:table):boolean|nil>

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = function()
    local ret = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      ---@type LspCustomSetup
      setup = {},
    }
    return ret
  end,
  config = function(_, opts)
    require("mason-lspconfig").setup()

    local lsp = require("util.lsp")

    lsp.on_attach(function(client, bufnr)
      lsp.create_lsp_keymaps(client, bufnr)
    end)

    local signs =
      { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend(
    --   "force",
    --   capabilities,
    --   require("cmp_nvim_lsp").default_capabilities()
    -- )

    ---Setup an LSP server.
    ---
    ---e.g.
    --- ```lua
    --- setup("lua_ls")
    --- ```
    ---@param server_name string `lspconfig` name of LSP server to set up.
    local function setup(server_name)
      local server_opts = opts.servers[server_name] or {}
      server_opts.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        capabilities, -- default capabilities
        opts.capabilities or {}, -- global capabilities
        server_opts.capabilities or {}
      )

      -- if there is a custom setup function, run it
      -- if it returns false, then it is just doing additional config. LSP will still be setup via standard `lspconfig`. <11j>
      -- if it returns true, then it is setting up the LSP itself, not using the standard `lspconfig` as in this function. <10j>
      if opts.setup[server_name] then
        if opts.setup[server_name](server_name, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server_name, server_opts) then
          return
        end
      end
      require("lspconfig")[server_name].setup(server_opts)
    end

    for server_name, _ in pairs(opts.servers) do
      setup(server_name)
    end
  end,
}
