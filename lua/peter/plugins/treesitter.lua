return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        -- INFO: c, query, lua, vim, vimdoc, markdown, markdown_inline should ALWAYS be installed
        "c",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "lua",
        "markdown",
        "markdown_inline",
      },

      -- don't auto install parsers when entering buffer
      auto_install = false,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          "ruby",
        },
        disable = {
          "latex",
        },
      },
      indent = {
        enable = true,
        disable = {
          "ruby",
        },
      },
    },
    config = function(_, opts)
      local lists = require("peter.util.lists")
      opts.ensure_installed =
        lists.remove_duplicates(opts.ensure_installed or {})

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- TODO: add other treesitter extensions/plugins
  -- * auto-tag
  -- * context
}
