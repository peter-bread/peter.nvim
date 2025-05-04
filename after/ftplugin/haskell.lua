local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()

-- Disable vim-matchup in Haskell files until this issue is resolved
-- https://github.com/andymass/vim-matchup/issues/348
vim.b.matchup_matchparen_enabled = 0

local set = vim.keymap.set

---Generate `opts` table for `vim.keymap.set` with default values and custom `desc` value
---@param desc string Description for keymap
---@return table vim.keymap.set.Opts Keymap opts table
local opts = function(desc)
  return {
    desc = desc,
    buffer = bufnr,
    noremap = true,
    silent = true,
  }
end

-- hoogle
set("n", "<localleader>s", ht.hoogle.hoogle_signature, opts("Search Hoogle"))

-- codelens
set("n", "<localleader>c", ht.lsp.buf_eval_all, opts("LSP Run All Codelens"))

-- repl
set("n", "<localleader>r", ht.repl.toggle, opts("Toggle GHCi repl (pkg)"))

set("n", "<localleader>R", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts("Toggle GHCi repl (buf)"))

set("n", "<localleader>q", ht.repl.quit, opts("Quit GHCi repl"))

-- HLS
set("n", "<localleader>s", ht.lsp.start, opts("HLS Start"))
set("n", "<localleader>S", ht.lsp.stop, opts("HLS Stop"))
set("n", "<localleader>e", ht.lsp.buf_eval_all, opts("HLS Eval All"))
