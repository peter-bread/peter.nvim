local set = vim.keymap.set

-- 1. General ==================================================================

set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

set({ "n", "i", "s" }, "<esc>", function()
  vim.snippet.stop() -- Exit current snippet (native snippets only).
  vim.cmd("noh") -- Clear search.
  return "<esc>" -- Standard <esc> behaviour.
end, { expr = true, desc = "Escape" }) -- Use `expr` to make sure "<esc>" is
--                                          actually evaluated.

-- 2. Splits ===================================================================

-- 2.a. Navigate splits --------------------------------------------------------

set("n", "<C-h>", "<C-w>h", { desc = "Focus left pane" })
set("n", "<C-j>", "<C-w>j", { desc = "Focus lower pane" })
set("n", "<C-k>", "<C-w>k", { desc = "Focus upper pane" })
set("n", "<C-l>", "<C-w>l", { desc = "Focus right pane" })

-- 2.b. Open splits ------------------------------------------------------------

set("n", "<leader>-", "<C-W>s", { desc = "Split below" })
set("n", "<leader>|", "<C-W>v", { desc = "Split right" })

-- 2.c. Resize splits ----------------------------------------------------------

set("n", "<M-=>", "<cmd>resize +2<cr>", { desc = "Increase height" })
set("n", "<M-->", "<cmd>resize -2<cr>", { desc = "Decrease height" })

-- These keymaps work for terminal emulators that support the Kitty Keyboard
-- Protocol. See 'https://sw.kovidgoyal.net/kitty/keyboard-protocol'.
--
-- You may need to use "<M-+>" and "<M-_>" for other terminal emulators.
--
-- By default, these will not work in WezTerm. Either use the `lhs` above or set
-- `enable_kitty_keyboard = true` in your WezTerm config.
set("n", "<M-S-=>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })
set("n", "<M-S-->", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })

-- 3. Buffers ==================================================================

-- TODO: Buffer keymaps.

-- 4. Lines ====================================================================

-- Move lines.
-- From: 'https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua'.
set("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
set("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
set("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
set("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move Selected Line(s) Down" })
set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move Selected Line(s) Up" })

-- 5. Indenting ================================================================

-- From: 'https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua'.
set("v", "<", "<gv")
set("v", ">", ">gv")

-- 6. Diagnostics ==============================================================

set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

do
  local diagnostic = require("peter.util.diagnostic")
  local next, prev = diagnostic.next, diagnostic.prev

    -- stylua: ignore start
    set("n", "]d", next, { desc = "Next Diagnostic" })
    set("n", "[d", prev, { desc = "Prev Diagnostic" })
    set("n", "]e", function() next({ severity = "ERROR" }) end, { desc = "Next Error" })
    set("n", "[e", function() prev({ severity = "ERROR" }) end, { desc = "Prev Error" })
    set("n", "]w", function() next({ severity = "WARN" }) end, { desc = "Next Warning" })
    set("n", "[w", function() prev({ severity = "WARN" }) end, { desc = "Prev Warning" })
  -- stylua: ignore end
end
