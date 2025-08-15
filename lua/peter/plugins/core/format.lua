---@module "lazy"
---@module "conform"

-- Formatting.
-- See 'https://github.com/stevearc/conform.nvim'.

---@type LazyPluginSpec[]
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
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
      default_format_options = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
      },
    },
  },
}
