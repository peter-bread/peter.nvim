-- Highlight and remove trailspace.
-- See https://github.com/nvim-mini/mini.trailspace'.

---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = require("peter.util.autocmds").augroup("TrimWhitespace"),
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },
}
