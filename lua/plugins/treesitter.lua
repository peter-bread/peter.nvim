return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        -- INFO: c, query, lua, vim, vimdoc should ALWAYS be installed
        "c",
        "query",
        "regex",

        -- TODO: (maybe) move to vim language file
        "vim",
        "vimdoc",

        -- TODO: (maybe) move to lua language file
        "lua",
      },

      -- don't auto install parsers when entering buffer
      auto_install = false,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          "ruby",
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
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- TODO: add other treesitter extensions/plugins
  -- * auto-tag
  -- * context
}
