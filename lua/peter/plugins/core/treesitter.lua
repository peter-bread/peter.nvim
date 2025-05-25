---@module "lazy"
---@module "nvim-treesitter"

-- install tree-sitter parsers
-- https://github.com/nvim-treesitter/nvim-treesitter

---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- plugin does *not* support lazy-loading
    branch = "main", -- eventually this will become the default branch
    build = ":TSUpdate",
    opts_extend = { "custom.ensure_installed" },

    ---@type {plugin:TSConfig,custom:table}
    opts = {
      ---@type TSConfig Actual config for setup funcion
      plugin = {
        install_dir = vim.fn.stdpath("data") .. "/site", -- default value
      },

      ---@type table Additional data for custom config, i.e. installing parsers
      custom = {
        ensure_installed = {
          -- INFO: these should ALWAYS be installed
          "c",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",

          -- miscellaneous parsers that do not fit into a "language" easily
          "regex",
        },
      },
    },

    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts.plugin)
      ts.install(opts.custom.ensure_installed)
    end,
  },
}
