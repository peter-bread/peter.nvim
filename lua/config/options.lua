local o = vim.opt
local g = vim.g

-- set leader key
g.mapleader = " "
g.maplocalleader = " "

g.have_nerd_font = true

g.markdown_recommended_style = 0

-- set line numbers
o.number = true
o.relativenumber = true

-- tabs and indentation
o.autoindent = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smarttab = true
o.shiftround = true

o.wrap = false

o.breakindent = true

o.confirm = true

o.spelllang = { "en" }

o.undofile = true

-- search options
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

o.signcolumn = "yes"
o.colorcolumn = "80"

o.timeoutlen = 300

-- split windows
o.splitright = true
o.splitbelow = true

o.list = true
-- opt.listchars = { tab = "", trail = "", nbsp = "" }

o.inccommand = "split"

o.cursorline = true
o.termguicolors = true
o.background = "dark"

o.backspace = "indent,eol,start"

o.clipboard:append("unnamedplus")

o.scrolloff = 16

-- o.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]
