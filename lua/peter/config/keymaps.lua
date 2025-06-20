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

do
  local diagnostic = require("peter.util.diagnostic")

  do
    local virtual_lines_active = false
    local virtual_text_config

    -- inspiration:
    -- https://www.reddit.com/r/neovim/comments/1jm5atz/replacing_vimdiagnosticopen_float_with_virtual
    --
    -- This is a 2-stage keymap.
    --
    -- First press:
    --  - disable virtual text
    --  - enable virtual lines
    --
    -- Second press:
    --  - disable virtual lines
    --  - re-enable virtual text (with correct settings)
    --  - open and focus diagnostic float
    set("n", "<leader>cd", function()
      if vim.bo.buftype == "nofile" then
        return
      end

      if virtual_lines_active then
        -- state 2: focus float
        vim.diagnostic.config({
          virtual_lines = false,
          virtual_text = virtual_text_config,
        })

        vim.diagnostic.open_float() -- open
        vim.diagnostic.open_float() -- focus

        virtual_lines_active = false
      else
        -- state 1: switch to virtual lines if there are diagnostics on current line
        if vim.tbl_isempty(diagnostic.current_line()) then
          return
        end

        virtual_text_config = vim.diagnostic.config().virtual_text

        vim.diagnostic.config({
          virtual_lines = { current_line = true },
          virtual_text = false,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
          group = require("peter.util.autocmds").augroup("LineDiagnostics"),
          callback = function()
            vim.diagnostic.config({ virtual_lines = false, virtual_text = virtual_text_config })
            virtual_lines_active = false
            return true
          end,
        })
        virtual_lines_active = true
      end
    end, { desc = "Line Diagnostics" })
  end

  -- stylua: ignore start
  set("n", "]d", diagnostic.next, { desc = "Next Diagnostic" })
  set("n", "[d", diagnostic.prev, { desc = "Prev Diagnostic" })
  set("n", "]e", function() diagnostic.next({ severity = "ERROR" }) end, { desc = "Next Error" })
  set("n", "[e", function() diagnostic.prev({ severity = "ERROR" }) end, { desc = "Prev Error" })
  set("n", "]w", function() diagnostic.next({ severity = "WARN" }) end, { desc = "Next Warning" })
  set("n", "[w", function() diagnostic.prev({ severity = "WARN" }) end, { desc = "Prev Warning" })
  -- stylua: ignore end

end

-- general =====================================================================

-- open lazy.nvim plugin manager
set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- super esc
set({ "n", "i", "s" }, "<esc>", function()
  vim.cmd("noh") -- clear search
  return "<esc>" -- standard esc behaviour
end, { expr = true, desc = "Escape+" }) -- expr to make sure "<esc>" is actually evaluated
