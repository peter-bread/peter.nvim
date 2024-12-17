local g = vim.g
local o = vim.opt

-- set leader key
g.mapleader = " "
g.maplocalleader = "\\"

g.have_nerd_font = true

g.markdown_recommended_style = 0

-- TODO: remove this when deleting cmp spec
---@type "standard"|"force_enabled"|"force_disabled"
g.cmp_status = "standard"

-- pop up menu height
o.pumheight = 15

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
o.colorcolumn = "80,120"

o.timeoutlen = 300

-- split windows
o.splitright = true
o.splitbelow = true

-- o.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

o.list = true

o.listchars = {
  nbsp = "+",
  eol = "󱞥",
  trail = "·",
  tab = "  ",
}

o.inccommand = "split"

o.cursorline = true
o.termguicolors = true
o.background = "dark"

o.backspace = "indent,eol,start"

o.clipboard:append("unnamedplus")

o.scrolloff = 16

o.exrc = true

o.statuscolumn = "%=%{v:relnum == 0 ? v:lnum : v:relnum} %s"
