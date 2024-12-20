local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("UserHighlightYank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
