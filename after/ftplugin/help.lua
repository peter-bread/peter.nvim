-- smaller scrolloff as help usually viewed in a horizontal split
vim.wo.scrolloff = 4

vim.wo.statuscolumn = ""

-- use `q` to close help page
vim.keymap.set("n", "q", "<cmd>q<cr>", {
  desc = "Quit",
  buffer = true,
})
