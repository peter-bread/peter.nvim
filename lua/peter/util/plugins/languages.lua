---@module "lazy"
---@module "conform"

---@class peter.util.plugins.lang
---@field treesitter fun(parsers:string[]):LazyPluginSpec
---@field mason fun(packages:peter.lang.masonPackage[]):LazyPluginSpec
---@field format fun(formatters_by_ft:peter.lang.formatters_by_ft):LazyPluginSpec
local M = {}

---@alias peter.lang.masonPackage string|{name:string, version?:string, condition?:fun():boolean}
---@alias peter.lang.formatters_by_ft table<string, conform.FiletypeFormatterInternal|fun(bufnr: integer):conform.FiletypeFormatterInternal>

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
---@param packages peter.lang.masonPackage[] List of packages to install.
---@return LazyPluginSpec
function M.mason(packages)
  return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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

return M
