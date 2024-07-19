local M = {}

-- stylua: ignore
---Set up packages, LSPs, formatters and linters for a programming language
---
---(Do not use for languages that have their own plugins which set up everything themselves, e.g. java or haskell)
---@param ts_ensure_installed table List of treesitter parsers that need to be installed
---   e.g.
---   ```lua
---     { "lua", "luadoc", "luau", "luap" }
---   ```
---@param mason_ensure_installed table List of packages that need to be installed via Mason
---   e.g.
---   ```lua
---     { "lua_ls", "stylua", "selene" }
---    ```
---@param nvim_lspconfig_opts table [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) opts table. Will be merged with parent specs.
---   e.g.
---   ```lua
---     {
---       servers = {
---         lua_ls = {
---           settings = {
---             Lua = {
---               diagnostics = {
---                 globals = {
---                   "vim",
---                 },
---               },
---             },
---           },
---         },
---       },
---       setup = {
---         lua_ls = function(_, opts)
---          -- server setup logic
---         end,
---       }
---     }
---   ```
---@return table spec Plugin spec to setup a programming language
function M.add_language(ts_ensure_installed, mason_ensure_installed, nvim_lspconfig_opts)
  return {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, ts_ensure_installed)
      end,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, mason_ensure_installed)
      end,
    },
    {
      "neovim/nvim-lspconfig",
      opts = nvim_lspconfig_opts,
    },
  }
end

return M