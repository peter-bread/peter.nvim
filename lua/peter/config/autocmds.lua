local autocmd = vim.api.nvim_create_autocmd

local augroup = require("peter.util.autocmd").augroup

-- Highlight on yank
autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("HighlightYank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
