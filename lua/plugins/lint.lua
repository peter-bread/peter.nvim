return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function(_, opts)
      local lint = require("lint")

      -- register linters
      lint.linters_by_ft = opts.linters_by_ft or {}

      -- autocmd to trigger linting
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          group = vim.api.nvim_create_augroup("lint", { clear = true }),
          callback = function()
            lint.try_lint()
          end,
        }
      )

      -- customise linters
      if opts.linters then
        for linter, properties in pairs(opts.linters) do
          -- this is how you could add new linter but this shouldn't be needed
          -- lint.linters[linter] = properties

          -- customise existing linters
          for property, details in pairs(properties) do
            lint.linters[linter][property] = details
          end
        end
      end
    end,
  },
}
