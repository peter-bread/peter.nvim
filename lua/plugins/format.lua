return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    -- stylua: ignore
    { "<leader>cf", function() require("conform").format({ async = true }) end, mode = "", desc = "Format Buffer" },
  },
  ---@module "conform"
  ---@alias formatOpts conform.setupOpts
  ---@type formatOpts
  opts = {
    format_on_save = { timeout_ms = 500 },
  },
}
