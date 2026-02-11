-- stylua: ignore start

-- 1. Globals ==================================================================

vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- Used by plugins to see whether to render icons or fallback to ASCII.
vim.g.have_nerd_font = true

-- Fix markdown indentation settings.
-- See `:helpg markdown_recommended_style`.
-- See 'https://github.com/tpope/vim-markdown/commit/b78bbce3371a2eb56c89f618cd4ab2baadc9ee61'.
vim.g.markdown_recommended_style = 0

--[[
Used to tell 'mini.icons' if it needs to export 'nvim_web_devicons' functions.

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

---Indicates whether Neovim is running in headless mode, i.e. there is no UI attached.
---
---When `true`, Neovim is headless. Operations should be run in a synchronous/blocking
---fashion.
---
---When `false`, Neovim is not headless. Operations should be run asynchronously.
---
---See `:h --headless`.
---@type boolean
vim.g.is_headless = #vim.api.nvim_list_uis() == 0

-- 2. Options ==================================================================

-- WARN: `vim.opt` will be deprecated.
-- Use `vim.o` where possible; only use `vim.opt` for Lua tables.
-- See 'https://github.com/neovim/neovim/issues/20107'.

-- 2.a Line Numbers ------------------------------------------------------------

vim.o.number          = true                -- Line numbers.
vim.o.relativenumber  = true                -- Relative line numbers.


-- 2.b. Tabs and Indentation ---------------------------------------------------

vim.o.autoindent      = true                -- Copy indent from current line when starting a new line.
vim.o.smartindent     = true                -- Do smart autoindenting when starting a new line.
vim.o.expandtab       = true                -- Use spaces instead of tabs.
vim.o.shiftwidth      = 2                   -- Size of indent.
vim.o.tabstop         = 2                   -- Number of spaces tabs count for.
vim.o.smarttab        = true                -- A <Tab> in front of a line inserts blanks according to 'shiftwidth'.
vim.o.shiftround      = true                -- Round indent.


-- 2.c. Search Options ---------------------------------------------------------

vim.o.ignorecase      = true                -- Ignore case while searching.
vim.o.smartcase       = true                -- Override the 'ignorecase' option if the search pattern contains uppercase characters.
vim.o.hlsearch        = true                -- Highlight search matches.
vim.o.incsearch       = true                -- Highlight search matches while typing search command.


-- 2.d. Split Windows ----------------------------------------------------------

vim.o.splitright      = true                -- Vertical splits open on the right.
vim.o.splitbelow      = true                -- Horizontal splits open below.


-- 2.e. Appearance -------------------------------------------------------------

vim.o.wrap            = false               -- Do not wrap lines.
vim.o.breakindent     = true                -- Wrapped text remains indented.
vim.o.scrolloff       = 8                   -- Minimal number of screen lines to keep above and below the cursor.
vim.o.signcolumn      = "yes"               -- Always draw the signcolumn.

vim.o.statuscolumn    = "%=%{v:relnum == 0 ? v:lnum : v:relnum} %s"
                                            -- Show current line number and relative numbers in a single column.

vim.o.cursorline      = true                -- Highlight current line.
vim.o.termguicolors   = true                -- Enable 24-bit RGB.
vim.o.background      = "dark"              -- Use dark background.

vim.o.pumheight       = 15                  -- Max height of pop-up menus.
vim.o.winborder       = "solid"             -- Default border style of floating windows.

-- TODO: Set to false once (if) there is a statusline
vim.o.showmode        = true                -- Do not show current mode (not needed with statusline).

vim.o.list            = true                -- Show invisible characters (e.g. trailing spaces).
vim.opt.listchars     = {                   -- Configure how invisible characters should be shown.
                        nbsp  = "+",
                        eol   = "󱞥",
                        trail = "·",
                        tab   = "  ",
                        }


-- 2.f. Other ------------------------------------------------------------------

vim.o.inccommand      = "split"             -- Shows the effects of commands as you type (e.g. |:substitute|).

-- TODO: Set up proper spell-checking.
vim.opt.spelllang     = {                   -- Allow British and American English.
                        "en_gb",
                        "en_us"
                        }

vim.o.undofile        = true                -- Save undo history into a file.
vim.o.timeoutlen      = 300                 -- Time in milliseconds to wait for a mapped sequence to complete.
vim.o.confirm         = true                -- Confirm saved changes before exiting buffer.

vim.o.backspace       = "indent,eol,start"  -- Backspace over autoindent, line breaks and start of insert.

vim.o.exrc            = true                -- Enables project-local configuration.
