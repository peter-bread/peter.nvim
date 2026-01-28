---@module "lazy"
---@module "nvim-treesitter"

-- Install tree-sitter parsers.
-- See 'https://github.com/nvim-treesitter/nvim-treesitter'.
-- See 'https://tree-sitter.github.io/tree-sitter'.

---@class peter.treesitter.Config : TSConfig
---@field ensure_installed? string[]

---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    build = ":TSUpdate",

    opts_extend = { "ensure_installed" },

    ---@type peter.treesitter.Config
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site", -- Default value.

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

    ---@param opts peter.treesitter.Config
    config = function(_, opts)
      local nts = require("nvim-treesitter")
      local autocmds = require("peter.util.autocmds")

      nts.setup(opts --[[@as TSConfig]])

      local ensure_installed = vim.list.unique(opts.ensure_installed or {})

      local already_installed = nts.get_installed()

      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      if #to_install > 0 and vim.fn.executable("tree-sitter") == 1 then
        if vim.g.is_headless then
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
            -- Highlighting.
            vim.treesitter.start(ev.buf, lang)

            -- Folding.
            -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.wo[0][0].foldmethod = "expr"

            -- Indentation (experimental).
            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
