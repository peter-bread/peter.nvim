---@module "lazy"
---@module "nvim-treesitter"

-- install tree-sitter parsers
-- https://github.com/nvim-treesitter/nvim-treesitter

---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
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
      local list = require("peter.util.list")

      ts.setup(opts.plugin)

      local ensure_installed = list.uniq(opts.custom.ensure_installed or {})

      local already_installed = ts.get_installed()

      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      -- stylua: ignore
      if #to_install > 0 then ts.install(to_install) end

      -- enable treesitter highlighting if available
      local autocmds = require("peter.util.autocmds")

      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = autocmds.augroup("EnableTreesitterHighlighting"),
        desc = "Try to enable tree-sitter syntax highlighting",
        pattern = "*",
        callback = function()
          pcall(function()
            vim.treesitter.start()
          end)
        end,
      })
    end,
  },
}
