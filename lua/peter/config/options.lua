-- stylua: ignore start

-- globals =====================================================================

vim.g.mapleader      = " "      -- leader
vim.g.maplocalleader = "\\"     -- local leader

vim.g.have_nerd_font = true     -- used for plugins that might need icons

vim.g.markdown_recommended_style = 0 -- fix markdown indentation settings

--[[
Used to tell mini.icons if it needs to export nvim_web_devicons functions.

Default: `false`.

This option can be set in two places:
  1. in `lua/peter/config/options.lua`
  2. in a plugin file **BEFORE** the spec is returned. (recommended for modularity)

      Example:
        ```lua
        -- lua/peter/plugins/core/some-plugin.lua

        vim.g.needs_nvim_web_devicons = true

        ---@type LazyPluginSpec[]
        return {
          {
            "someone/some-plugin",
            opts = {...},
            ...
          },
        }
        ```
]]
---@type boolean
vim.g.needs_nvim_web_devicons = false

-- options =====================================================================

-- WARN: `vim.opt` will be deprecated.
-- Use `vim.o` where possible; only use `vim.opt` for lua tables
-- https://github.com/neovim/neovim/issues/20107

-- line numbers ----------------------------------------------------------------

vim.o.number          = true      -- line numbers
vim.o.relativenumber  = true      -- relative line numbers


-- tabs and indentation --------------------------------------------------------

vim.o.autoindent      = true      -- copy indent from current line when starting a new line
vim.o.smartindent     = true      -- do smart autoindenting when starting a new line
vim.o.expandtab       = true      -- use spaces instead of tabs
vim.o.shiftwidth      = 2         -- size of indent
vim.o.tabstop         = 2         -- number of spaces tabs count for
vim.o.smarttab        = true      -- a <Tab> in front of a line inserts blanks according to 'shiftwidth'
vim.o.shiftround      = true      -- round indent


-- search options --------------------------------------------------------------

vim.o.ignorecase      = true      -- ignore case while searching
vim.o.smartcase       = true      -- override the 'ignorecase' option if the search pattern contains uppercase characters
vim.o.hlsearch        = true      -- highlight search matches
vim.o.incsearch       = true      -- highlight search matches while typing search command


-- split windows ---------------------------------------------------------------

vim.o.splitright      = true      -- vertical splits open on the right
vim.o.splitbelow      = true      -- horizontal splits open below


-- appearance ------------------------------------------------------------------
-- basic UI layout
vim.o.wrap            = false     -- do not wrap lines
vim.o.breakindent     = true      -- wrapped text remains indented
vim.o.scrolloff       = 8         -- minimal number of screen lines to keep above and below the cursor
vim.o.signcolumn      = "yes"     -- always draw the signcolumn

vim.o.statuscolumn    = "%=%{v:relnum == 0 ? v:lnum : v:relnum} %s"

-- visual enhancements
vim.o.cursorline      = true      -- highlight current line
vim.o.colorcolumn     = "80"      -- highlight column 80
vim.o.termguicolors   = true      -- enable 24-bit RGB
vim.o.background      = "dark"    -- use dark background

-- completion/menu UI
vim.o.pumheight       = 15        -- max height of pop-up menus

-- mode/status UI
-- TODO: set to false once there is a statusline
vim.o.showmode        = true      -- do not show current mode (not needed with statusline)

-- invisible characters
vim.o.list            = true      -- show invisible characters (e.g. trailing spaces)
vim.opt.listchars     = {         -- configure how invisible characters should be shown
                          nbsp  = "+",
                          eol   = "󱞥",
                          trail = "·",
                          tab   = "  ",
                        }

-- other -----------------------------------------------------------------------

vim.o.inccommand      = "split"   -- shows the effects of commands as you type (e.g. |:substitute|)

-- TODO: set up proper spell-checking
vim.opt.spelllang     = {         -- allow british and american english
                          "en_gb",
                          "en_us"
                        }

vim.o.undofile        = true      -- save undo history into a file
vim.o.timeoutlen      = 300       -- time in milliseconds to wait for a mapped sequence to complete
vim.o.confirm         = true      -- confirm saved changes before exiting buffer

-- backspace over autoindent, line breaks and start of insert
vim.o.backspace       = "indent,eol,start"

-- stylua: ignore end
