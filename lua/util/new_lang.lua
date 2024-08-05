---@meta

---@class New_Lang
---Utility module that provides wrapper functions to make adding support for different programming languages easier.
---
---Each function in this module returns a Lazy plugin spec.
---
---# Usage
---
---Say we want to add basic support for Lua.
---Create a file in your plugins folder `lua/plugins/languages/lua.lua`.
---This relies on merging `opts` tables wiht parent specs via the Lazy plugin manager.
---For this reason, it is important that the plugins are loaded as a separate spec:
---
--- ```lua
--- -- lazy plugin manager setup:
--- require("lazy").setup({
---   spec = {
---     { import = "plugins" },
---     { import = "plugins.languages" },
---   },
--- ```
---
--- ```lua
--- -- lua/plugins/languages/lua.lua:
--- local L = require("util.new_lang")
---
--- return {
---   L.treesitter({ "lua", "luadoc" }),
---   L.mason({ "lua_ls", "stylua" }),
---   L.lspconfig({
---     servers = {
---       lua_ls = {},
---     },
---   }),
---   L.format({
---     formatters_by_ft = {
---       lua = { "stylua" },
---     },
---   })
---   -- add any more plugins here...
--- }
--- ```
--- > **Note:**
--- >
--- > You can also require a module like this:
--- > ```lua
--- > ---@module "util.new_lang"
--- > local L
--- > ```
local M = {}

---Add treesitter parsers that need to be installed.
---@param parsers string[] List of parser names.
---@return table [`treesitter`](nvim-treesitter/nvim-treesitter) Lazy plugin spec.
---# Usage
---
--- ```lua
--- treesitter({
---   "go",
---   "gomod",
---   "gosum",
---   "gotmpl",
---   "gowork",
--- })
--- ```
function M.treesitter(parsers)
  if not parsers then
    return {}
  end
  return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, parsers)
    end,
  }
end

---Add mason packages that need to be installed.
---@param packages string[] List of package names.
---@return table [`mason-tool-installer`](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) Lazy plugin spec.
---# Usage
---
--- ```lua
--- mason({
---   "gopls", -- lsp
---   "gofumpt", -- formatter
---   "goimports", -- formatter
---   "golangci-lint", -- linter
---   "delve", -- dap
--- })
--- ```
function M.mason(packages)
  if not packages then
    return {}
  end
  return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, packages)
    end,
  }
end

---@alias server table<string, table>
---@alias setup CustomLspSetup
---@alias lspOpts {servers:server, setup?:setup}

---Set up LSP.
---@param opts lspOpts Server settings and optional function for additional setup.
---@return table [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) Lazy plugin spec.
---# Usage
---
--- ```lua
--- lspconfig({
---   -- standard server settings/configuration
---   servers = {
---     gopls = {
---       -- gopls settings here
---     },
---   },
---
---   -- additional server setup
---   setup = {
---     gopls = function(server, opts)
---       -- additional config here
---       -- return false or nil to use standard lspconfig setup.
---       -- return true if this function sets up up lsp fully.
---     end,
---   },
--- })
--- ```
function M.lspconfig(opts)
  return {
    "neovim/nvim-lspconfig",
    opts = opts,
  }
end

---@module "conform"

---Set up formatting.
---@param opts conform.setupOpts Options to set up conform.nvim.
---@return table [`conform`](https://github.com/stevearc/conform.nvim) Lazy plugin spec.
---# Usage
---
--- ```lua
--- format({
---   -- set up formatters to run on filetype
---   formatters_by_ft = {
---     lua = { "stylua" }, -- single formatter
---     go = { "goimports", "gofumpt" }, -- run sequentially
---     rust = { "rustfmt", lsp_format = "fallback" }, -- customise options
---     javascript = { "prettierd", "prettier", stop_after_first = true }, -- run first available
---   }
---
---   -- customise individual formatters
---   formatters = {
---     yamlfix = {
---       -- Change where to find the command
---       command = "local/path/yamlfix",
---       -- Adds environment args to the yamlfix formatter
---       env = {
---         YAMLFIX_SEQUENCE_STYLE = "block_style",
---       },
---     },
---   },
--- })
--- ```
--- Use `:h conform` for more info.
function M.format(opts)
  return {
    "stevearc/conform.nvim",
    opts = opts,
  }
end

---Set up linting.
---@param opts table Opts table. See `:h nvim-lint-usage`.
---@return table [`nvim-lint`](https://github.com/mfussenegger/nvim-lint) Lazy plugin spec.
---# Usage
---
--- ```lua
--- lint({
---   -- linters to run by filetype
---   linters_by_ft = {
---     lua = { "selene" },
---   },
---
---   -- customise linters
---   linters = {
---     selene = {
---       args = { "-q" },
---     },
---   },
--- })
--- ```
function M.lint(opts)
  return {
    "mfussenegger/nvim-lint",
    opts = opts,
  }
end

---@module "neotest"

---Set up testing.
---@param config {dep:string,opts:neotest.Config} Adapter dependencies and registration.
---@return table
---# Usage
---
--- ```lua
--- test({
---   -- add adapter for test runner as plugin dependency
---   dep = "fredrikaverpil/neotest-golang",
---
---   -- register adapter
---   opts = {
---     adapters = {
---       ["neotest-golang"] = {},
---     },
---   },
--- })
--- ```
function M.test(config)
  return {
    "nvim-neotest/neotest",
    dependencies = config.dep,
    opts = config.opts,
  }
end

---@alias CustomDapAdapter table<string,table|fun():table>
---@alias CustomDapConfiguration table<string,table[]>
---@alias CustomDapDeps string|string[]

---Setup DAP.
---@param params {adapters:CustomDapAdapter,configurations:CustomDapConfiguration}|{deps:CustomDapDeps,setup:fun()} Table used to set up DAP. Can either be `adapters` *and* `configurations` for manual setup ***or*** `dep` *and* `setup` for automatic setup via a plugin.
---@return table [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) Lazy plugin spec.
---# Usage
---
---## Manual DAP Setup
---
--- ```lua
--- dap({
---   -- add debug adapters:
---   adapters = {
---     -- Needs to be a function since elixir-ls is installed with mason.
---     -- This means the executable is only added to PATH after mason starts.
---     -- But the Lazy package manager merges `opts` tables *BEFORE* any plugins are loaded,
---     -- So if this was a table, you would get: command = "".
---     -- This *CAN* be a table when you don't need to delay any kind of execution,
---     -- e.g. all values are hard-coded:
---     --    command = "/path/to/elixir-ls-debugger"
---     mix_task = function()
---       return {
---         type = "executable",
---         command = vim.fn.exepath("elixir-ls-debugger"),
---         args = {},
---       }
---     end,
---   },
---   configurations = {
---     -- add debug configurations per filetype:
---     elixir = {
---       {
---         type = "mix_task",
---         name = "mix task",
---         task = "test",
---         request = "launch",
---         projectDir = "${workspaceFolder}",
---       },
---       -- more configurations for elixir here...
---     },
---   },
--- })
--- ```
---
---## Auto DAP Setup (via plugin(s))
---
--- ```lua
--- dap({
---   -- Add dependencies for the DAP setup. This can be:
---   -- 1. A single plugin:
---   deps = "leoluz/nvim-dap-go",
---
---   -- 2. A list of plugins:
---   deps = { "leoluz/nvim-dap-go", "another/plugin" },
---
---   -- 3. A table with multiple plugins (and optionally, options):
---   deps = {
---     "leoluz/nvim-dap-go",
---     "another/plugin",
---     -- other dependencies
---   },
---
---   -- function to setup plugins:
---   setup = function()
---     require("dap-go").setup()
---   end,
--- })
--- ```
function M.dap(params)
  -- base plugin spec
  local spec = {
    "mfussenegger/nvim-dap",
  }

  -- manual DAP setup
  if
    params.adapters
    and params.configurations
    and not (params.deps or params.setup)
  then
    spec.opts = function(_, opts)
      -- manual
      -- add adapter
      opts.adapters = opts.adapters or {}
      for adapter, config in pairs(params.adapters or {}) do
        if type(config) == "function" then
          opts.adapters[adapter] = config()
        elseif type(config) == "table" then
          opts.adapters[adapter] = config
        end
      end

      -- add configurations
      opts.configurations = opts.configurations or {}
      for ft, configs in pairs(params.configurations or {}) do
        opts.configurations[ft] = vim.tbl_deep_extend(
          "force",
          {},
          opts.configurations[ft] or {},
          configs or {}
        )
      end
    end

    -- automatic DAP setup (via plugin)
  elseif
    params.deps
    and params.setup
    and not (params.adapters or params.configurations)
  then
    spec.dependencies = params.deps
    spec.opts = function(_, opts)
      opts.language_extensions = opts.language_extensions or {}
      vim.list_extend(opts.language_extensions, {
        params.setup,
      })
    end
  else
    vim.notify(
      "Invalid args passed into DAP setup.\nArgument should be: {adapters,configurations}|{dep,setup}",
      vim.log.levels.ERROR
    )
  end
  return spec
end

return M
