return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
    -- stylua: ignore start
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers" },
    { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    { "<M-S-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "<M-S-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      -- stylua: ignore end
    },
    opts = {
      options = {
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag, _)
          local icons = require("peter.util.icons")
          local signs = icons.diagnostics.fill

          local ret = (diag.error and signs.Error .. diag.error .. " " or "")
            .. (diag.warning and signs.Warn .. diag.warning or "")

          return vim.trim(ret)
        end,
      },
    },
  },
}
