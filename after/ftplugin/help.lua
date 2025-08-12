-- Usually viewed in a horizontal split.
vim.wo.scrolloff = 4

-- By default, 'number' and 'relativenumber' are disabled and there are no
-- diagnostics. Therefore there is no need for 'statuscolumn'.
vim.wo.statuscolumn = ""

vim.keymap.set("n", "q", "<cmd>q<cr>", {
  desc = "Quit",
  buffer = true,
})
