---@module "lazy"
---@module "nvim-treesitter"

-- install tree-sitter parsers
-- https://github.com/nvim-treesitter/nvim-treesitter

---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdate", "TSUpdateSync", "TSInstall" },
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },

    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
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

      auto_install = false,

      -- TODO: other config
    },
    config = function(_, opts)
      local list = require("peter.util.list")
      opts.ensure_installed = list.uniq(opts.ensure_installed or {})
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
