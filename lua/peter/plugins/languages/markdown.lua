local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "markdown",
    "markdown_inline",
  }),

  L.mason({
    "marksman", -- lsp
    "prettier", -- formatter
    "markdownlint-cli2", -- formatter/linter
  }),

  L.lspconfig({
    servers = {
      marksman = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      markdown = { "prettier", "markdownlint-cli2" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2" },
    },
  }),

  L.lint({
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
  }),

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "norg", "rmd", "org" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
  },

  --
  -- {
  --   "peter-bread/md-toc.nvim",
  --   ft = { "markdown" },
  --   ---@type TocOpts
  --   opts = {},
  -- },

  ---@module "toc"

  {
    dir = "/Users/petersheehan/Developer/peter-bread/nvim-plugins/md-toc.nvim",
    ft = { "markdown" },
    ---@type TocOpts
    opts = {},
  },

  {
    "bullets-vim/bullets.vim",
    cond = false, -- disable for now to make sure snacks.picker works
    ft = { "markdown" },
    config = function()
      -- This is necessary for snacks.picker to always work
      -- https://github.com/folke/snacks.nvim/issues/812#issuecomment-2628819060
      vim.g.bullets_enable_in_empty_buffers = 0
    end,
  },
}
