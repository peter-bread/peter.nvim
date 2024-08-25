local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local lsp = require("util.lsp")

vim.keymap.set("n", "<leader>sh", ht.hoogle.hoogle_signature, {
  desc = "Search Hoogle",
  buffer = bufnr,
  noremap = true,
  silent = true,
})

lsp.on_attach(function(client, buf)
  vim.keymap.set("n", "<leader>cA", ht.lsp.buf_eval_all, {
    desc = "LSP Run All Codelens",
    buffer = buf,
    noremap = true,
    silent = true,
  })
end, "haskell-tools.nvim")
