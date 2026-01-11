---@module "lazy"
---@module "conform"

---@alias peter.lang.masonPackage string | { [1]: string, version: string, condition:fun():boolean}
---@alias peter.lang.formatters_by_ft table<string, conform.FiletypeFormatterInternal|fun(bufnr: integer):conform.FiletypeFormatterInternal>

---@class peter.util.plugins.lang
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Add treesitter parsers to be installed.
---Plugin: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main).
---@param parsers string[] List of parser names.
---@return LazyPluginSpec
function M.treesitter(parsers)
  return {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      custom = {
        ensure_installed = parsers or {},
      },
    },
  }
end

---Add mason packages to be installed.
---Plugin: [mason.nvim](https://github.com/mason-org/mason.nvim).
---
---Example:
---
--- ```lua
--- -- Standard
--- L.mason({ "gopls" })
---
--- -- Additional options
--- L.mason({ "gopls" , version = "v0.19.1", auto_update = false, condition = function()
---   return vim.fn.executable("go") == 1
--- end })
--- ```
---@param packages peter.lang.masonPackage[] List of packages to install.
---@return LazyPluginSpec
function M.mason(packages)
  return {
    "mason-org/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = packages or {},
    },
  }
end

---Register formatters by filetype.
---Plugin: [conform.nvim](https://github.com/stevearc/conform.nvim).
---@param formatters_by_ft peter.lang.formatters_by_ft Mapping of filetypes to formatters.
---@return LazyPluginSpec
function M.format(formatters_by_ft)
  return {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = formatters_by_ft or {},
    },
  }
end

---Register linters by filetype.
---Plugin [nvim-lint](https://github.com/mfussenegger/nvim-lint).
---@param linters_by_ft table<string,string[]> Mapping of filetypes to linters.
---@return LazyPluginSpec
function M.lint(linters_by_ft)
  return {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = linters_by_ft or {},
    },
  }
end

return M
