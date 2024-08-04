return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    -- stylua: ignore
    { "<leader>cf", function() require("conform").format({ async = true }) end, mode = "", desc = "Format Buffer" },
  },
  ---@type conform.setupOpts
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = "fallback",
    },
  },
}
