local autocmds = require("peter.util.autocmds")

local autocmd = vim.api.nvim_create_autocmd
local augroup = autocmds.augroup

autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("HighlightYank"),
  callback = function()
    vim.hl.on_yank()
  end,
})
