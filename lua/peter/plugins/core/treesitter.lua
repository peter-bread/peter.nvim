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
          "make", -- TODO: Move this to a language file if I ever use a Makefile linter or formatter.
          "regex",
        },
      },
    },

    config = function(_, opts)
      local nts = require("nvim-treesitter")
      local list = require("peter.util.list")
      local autocmds = require("peter.util.autocmds")

      nts.setup(opts.plugin)

      local ensure_installed = list.uniq(opts.custom.ensure_installed or {})

      local already_installed = nts.get_installed()

      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      if #to_install > 0 and vim.fn.executable("tree-sitter") == 1 then
        local is_headless = #vim.api.nvim_list_uis() == 0
        if is_headless then
          nts.install(to_install):wait(300000)
        else
          nts.install(to_install)
        end
      end

      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = autocmds.augroup("EnableTreesitterHighlighting"),
        desc = "Try to enable tree-sitter syntax highlighting",
        callback = function(ev)
          local filetype = ev.match
          local lang = vim.treesitter.language.get_lang(filetype)
          if lang and vim.treesitter.language.add(lang) then
            -- TODO: Use Treesitter for folds and indents.
            -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.start(ev.buf, lang)
          end
        end,
      })
    end,
  },
}
