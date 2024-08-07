local L = require("util.new_lang")

return {
  L.treesitter({
    "markdown",
    "markdown_inline",
  }),

  L.mason({
    "marksman", -- lsp
    "prettier", -- formatter
    "markdownlint-cli2", -- formatter/linter
    "markdown-toc", -- formatter (for Table of Contents)
  }),

  L.lspconfig({
    servers = {
      marksman = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      markdown = { "prettier", "markdownlint-cli2", "markdown-toc", "injected" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
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
}
