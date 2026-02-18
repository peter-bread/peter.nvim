local set = vim.keymap.set

-- 1. General ==================================================================

set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

set({ "n", "i", "s" }, "<esc>", function()
  vim.snippet.stop() -- Exit current snippet (native snippets only).
  vim.cmd("noh") -- Clear search.
  return "<esc>" -- Standard <esc> behaviour.
end, { expr = true, desc = "Escape" }) -- `expr` to make sure "<esc>" is actually evaluated.

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

-- These keymaps work for terminal emulators that support the Kitty Keyboard Protocol.
-- See 'https://sw.kovidgoyal.net/kitty/keyboard-protocol'.
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

do
  local diagnostic = require("peter.util.diagnostic")

  do
    local virtual_lines_active = false
    local virtual_text_config

    -- Inspiration:
    -- 'https://www.reddit.com/r/neovim/comments/1jm5atz/replacing_vimdiagnosticopen_float_with_virtual'.
    --
    -- This is a 2-stage keymap.
    --
    -- First press:
    --  - Disable virtual text.
    --  - Enable virtual lines.
    --
    -- Second press:
    --  - Disable virtual lines.
    --  - Re-enable virtual text (with original settings).
    --  - Open and focus diagnostic float.
    set("n", "<leader>cd", function()
      if vim.bo.buftype == "nofile" then
        return
      end

      if not virtual_lines_active then
        -- State 1: Switch to virtual lines if there are diagnostics on current line.
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
            vim.diagnostic.config({
              virtual_lines = false,
              virtual_text = virtual_text_config,
            })
            virtual_lines_active = false
            return true
          end,
        })
        virtual_lines_active = true
      else
        -- State 2: Focus float.
        vim.diagnostic.config({
          virtual_lines = false,
          virtual_text = virtual_text_config,
        })

        vim.diagnostic.open_float() -- Open.
        vim.diagnostic.open_float() -- Focus.

        virtual_lines_active = false
      end
    end, { desc = "Line Diagnostics" })
  end

  do
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
end
