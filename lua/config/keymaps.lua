-- abbreviated
local set = vim.keymap.set

-- clear search highlighting in normal mode with ESC
set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search hl" })

-- navigate splits
set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left pane" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower pane" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper pane" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right pane" })
set("n", "<leader>-", "<C-W>s", { desc = "Split below", remap = true })
set("n", "<leader>|", "<C-W>v", { desc = "Split right", remap = true })

-- resize splits
set("n", "<M-+>", "<C-w>5>") -- wider
set("n", "<M-_>", "<C-w>5<") -- narrower
set("n", "<M-=>", "<C-w>+") -- taller
set("n", "<M-->", "<C-w>-") -- shorter

-- navigate buffers
set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Move Lines
-- from: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
set("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
set("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
set("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
set("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move Selected Line(s) Down" })
set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move Selected Line(s) Up" })

-- better indenting
-- from: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
set("v", "<", "<gv")
set("v", ">", ">gv")

-- insert blank lines
set("n", "<leader>o", "o<esc>", { desc = "Insert line below" })
set("n", "<leader>O", "O<esc>", { desc = "Insert line above" })

-- open lazy package manager
set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- diagnostics
-- stylua: ignore start
set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
set("n", "]e", function() vim.diagnostic.goto_next({ severity = "ERROR" }) end, { desc = "Next Error" })
set("n", "[e", function() vim.diagnostic.goto_prev({ severity = "ERROR" }) end, { desc = "Prev Error" })
set("n", "]w", function() vim.diagnostic.goto_next({ severity = "WARN" }) end, { desc = "Next Warning" })
set("n", "[w", function() vim.diagnostic.goto_prev({ severity = "WARN" }) end, { desc = "Prev Warning" })
-- stylua: ignore end

set("n", "<leader>ud", function()
  vim.diagnostic.enable(
    not vim.diagnostic.is_enabled({ bufnr = 0 }),
    { bufnr = nil }
  )
end, { desc = "Toggle Diagnostics (Buf)" })

set("n", "<leader>uD", function()
  vim.diagnostic.enable(
    not vim.diagnostic.is_enabled({ bufnr = 0 }),
    { bufnr = 0 }
  )
end, { desc = "Toggle Diagnostics (Buf)" })

-- toggle background
-- stylua: ignore
set("n", "<leader>ub", require("util.ui").toggle_background, { desc = "Toggle background" })

set("n", "<leader>nc", function()
  vim.cmd.cd(vim.fn.stdpath("config"))
  vim.cmd("e")
end, { desc = "cd to config" })

set("n", "<leader>uc", function()
  if vim.o.conceallevel == 0 then
    vim.o.conceallevel = 2
  else
    vim.o.conceallevel = 0
  end
end, { desc = "Toggle Conceal Level" })
