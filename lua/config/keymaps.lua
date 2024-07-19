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

-- insert blank lines
set("n", "<leader>o", "o<esc>", { desc = "Insert line below" })
set("n", "<leader>O", "O<esc>", { desc = "Insert line above" })

-- open lazy package manager
set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- toggle background
-- stylua: ignore
set("n", "<leader>ut", require("util.ui").toggle_background, { desc = "Toggle background" })

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
