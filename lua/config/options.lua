-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.have_nerd_font = true

vim.g.markdown_recommended_style = 0

-- TODO: remove this when deleting cmp spec
---@type "standard"|"force_enabled"|"force_disabled"
vim.g.cmp_status = "standard"

-- pop up menu height
vim.opt.pumheight = 15

-- set line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs and indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.shiftround = true

vim.opt.wrap = false

vim.opt.breakindent = true

vim.opt.confirm = true

vim.opt.spelllang = { "en" }

vim.opt.undofile = true

-- search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,120"

vim.opt.timeoutlen = 300

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

vim.opt.list = true

vim.opt.listchars = {
  nbsp = "+",
  eol = "󱞥",
  trail = "·",
  tab = "  ",
}

vim.opt.inccommand = "split"

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.backspace = "indent,eol,start"

vim.opt.clipboard:append("unnamedplus")

vim.opt.scrolloff = 16

vim.opt.exrc = true

vim.opt.statuscolumn = "%=%{v:relnum == 0 ? v:lnum : v:relnum} %s"
