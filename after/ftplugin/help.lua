-- smaller scrolloff as help usually viewed in a vertical split
vim.wo.scrolloff = 4

-- use `q` to close help page
vim.keymap.set("n", "q", "<cmd>q<cr>", {
  desc = "Quit",
  buffer = true,
})
