return {
  {
    "folke/snacks.nvim",
    priority = 950,
    lazy = false,

    ---@module "snacks"
    ---@type snacks.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {},
    keys = {},
    init = function()
      vim.api.nvim_create_autocmd("User", {
        group = require("peter.util.autocmds").augroup("SnacksInit"),
        pattern = "VeryLazy",
        callback = function()
          local toggle = require("snacks").toggle

          toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

          toggle.diagnostics():map("<leader>ud")

          -- stylua: ignore
          toggle.option("background", {
            off = "light",
            on = "dark",
            name = "Dark Background",
            notify = false,
          }):map("<leader>ub")

          -- stylua: ignore
          toggle.option("conceallevel", {
            off = 0,
            on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
            name = "Conceal Level",
          }):map("<leader>uc")

          toggle.inlay_hints():map("<leader>uh")

          toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
}
