return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format Buffer",
    },
    {
      "<leader>cF",
      function()
        require("conform").format({
          formatters = { "injected" },
          timeout_ms = 3000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  ---@type conform.setupOpts
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      lsp_format = "fallback",
    },
    format_on_save = {},
  },
}
