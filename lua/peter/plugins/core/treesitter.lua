---@module "lazy"
---@module "nvim-treesitter"

-- Install tree-sitter parsers.
-- See 'https://github.com/nvim-treesitter/nvim-treesitter'.
-- See 'https://tree-sitter.github.io/tree-sitter'.

---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    branch = "main", -- Eventually this will become the default branch.
    build = ":TSUpdate",

    opts_extend = { "custom.ensure_installed" },

    ---@type {plugin:TSConfig,custom:table}
    opts = {
      ---@type TSConfig Actual config for setup funcion.
      plugin = {
        install_dir = vim.fn.stdpath("data") .. "/site", -- Default value.
      },

      ---@type table Additional data for custom config, i.e. installing parsers.
      custom = {
        ensure_installed = {
          -- INFO: These should ALWAYS be installed.
          "c",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",

          -- Miscellaneous parsers that do not fit into a "language" easily.
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

      if #to_install > 0 and vim.fn.executable("tree-sitter") == 1 then
        ts.install(to_install)
      end

      local autocmds = require("peter.util.autocmds")

      -- TODO: Either remove `pattern = "*"` or use autocmd from 'tiny.nvim'.
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = autocmds.augroup("EnableTreesitterHighlighting"),
        desc = "Try to enable tree-sitter syntax highlighting",
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
