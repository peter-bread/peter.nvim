-- keymaps

-- abbreviation
local set = vim.keymap.set

-- splits ======================================================================

-- navigate splits -------------------------------------------------------------
set("n", "<C-h>", "<C-w>h", { desc = "Focus left pane" })
set("n", "<C-j>", "<C-w>j", { desc = "Focus lower pane" })
set("n", "<C-k>", "<C-w>k", { desc = "Focus upper pane" })
set("n", "<C-l>", "<C-w>l", { desc = "Focus right pane" })

-- open splits -----------------------------------------------------------------
set("n", "<leader>-", "<C-W>s", { desc = "Split below" })
set("n", "<leader>|", "<C-W>v", { desc = "Split right" })

-- resize splits ---------------------------------------------------------------
do
  -- height
  set("n", "<M-=>", "<cmd>resize +2<cr>", { desc = "Increase height" }) -- taller
  set("n", "<M-->", "<cmd>resize -2<cr>", { desc = "Decrease height" }) -- shorter

  -- width
  -- HACK: does not work the same with all terminal emulators
  -- I think this is due to xterm-ghostty vs xterm-256screen terminfo entries
  local split_width_lhs

  if vim.list_contains({ "ghostty" }, vim.env.TERM_PROGRAM) then
    split_width_lhs = { inc = "<M-S-=>", dec = "<M-S-->" }
  else
    split_width_lhs = { inc = "<M-+>", dec = "<M-_>" }
  end

  -- stylua: ignore start
  set("n", split_width_lhs.inc, "<cmd>vertical resize +2<cr>", { desc = "Increase width" }) -- wider
  set("n", split_width_lhs.dec, "<cmd>vertical resize -2<cr>", { desc = "Decrease width" }) -- narrower
  -- stylua: ignore end
end

-- buffers =====================================================================

-- TODO: buffer keymaps

-- lines =======================================================================

-- move lines
-- from: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
set("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
set("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
set("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
set("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move Selected Line(s) Down" })
set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move Selected Line(s) Up" })

-- indenting ===================================================================

-- from: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
set("v", "<", "<gv")
set("v", ">", ">gv")

-- diagnostics ==================================================================

local diagnostic = require("peter.util.diagnostic")

-- stylua: ignore start
set("n", "]d", diagnostic.next, { desc = "Next Diagnostic" })
set("n", "[d", diagnostic.prev, { desc = "Prev Diagnostic" })
set("n", "]e", function() diagnostic.next({ severity = "ERROR" }) end, { desc = "Next Error" })
set("n", "[e", function() diagnostic.prev({ severity = "ERROR" }) end, { desc = "Prev Error" })
set("n", "]w", function() diagnostic.next({ severity = "WARN" }) end, { desc = "Next Warning" })
set("n", "[w", function() diagnostic.prev({ severity = "WARN" }) end, { desc = "Prev Warning" })
-- stylua: ignore end

-- general =====================================================================

-- open lazy.nvim plugin manager
set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- super esc
set({ "n", "i", "s" }, "<esc>", function()
  vim.cmd("noh") -- clear search
  return "<esc>" -- standard esc behaviour
end, { expr = true, desc = "Escape+" }) -- expr to make sure "<esc>" is actually evaluated
