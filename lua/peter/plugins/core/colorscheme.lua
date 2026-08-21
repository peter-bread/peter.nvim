---@module "lazy"
---@diagnostic disable: missing-fields, unused-local

-- Colourscheme.
-- See 'https://github.com/rebelot/kanagawa.nvim'.

---@type LazyPluginSpec[]
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,

    ---@type KanagawaConfig
    opts = {
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },

      ---@param colors KanagawaColors
      overrides = function(colors)
        local palette = colors.palette
        local theme = colors.theme

        local get = function(name)
          return vim.api.nvim_get_hl(0, { name = name })
        end

        -- stylua: ignore
        local dark_popup_menus = {
          Pmenu      = {              bg = theme.ui.bg_p1 },
          PmenuSel   = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar  = {              bg = theme.ui.bg_m1 },
          PmenuThumb = {              bg = theme.ui.bg_p2 },
        }

        -- Based on GitHub Colorblind Dark Mode Hex Tokens
        -- stylua: ignore
        local gh = {
          -- 1. Base 4 Colors
          add_bg        = "#15223a", -- Add line background
          add_inline_bg = "#234d87", -- Add word/inline background
          del_bg        = "#2c201b", -- Delete line background
          del_inline_bg = "#733d22", -- Delete word/inline background

          -- 2. GitHub Dark Mode Accents (for text/signs)
          add_fg = "#539bf5", -- GitHub blue text
          del_fg = "#e36049", -- GitHub orange/red text

          -- 3. Derived Cursor Line Backgrounds (halfway between line_bg and inline_bg)
          add_cursor_bg = "#1b2c4a",
          del_cursor_bg = "#382923",
        }

        -- stylua: ignore
        local normal_diff = {
          -- Vim Diff & Treesitter
          ["@diff.plus"]  = { fg = gh.add_fg,         bg = gh.add_bg                       },
          diffAdded       = {                                         link = "@diff.plus"  },
          DiffAdd         = {                         bg = gh.add_bg                       },
          diffNewFile     = { fg = get("Special").fg, bg = gh.add_bg                       },

          ["@diff.minus"] = { fg = gh.del_fg,         bg = gh.del_bg                       },
          DiffDelete      = {                         bg = gh.del_bg                       },
          diffRemoved     = {                                         link = "@diff.minus" },
          diffOldFile     = { fg = get("Special").fg, bg = gh.del_bg                       },
        }

        -- stylua: ignore
        local neogit_diff = {
          -- Additions
          NeogitDiffAdd             = { link = "@diff.plus"                                },
          NeogitDiffAddHighlight    = {                 bg = gh.add_bg                     },
          NeogitDiffAddCursor       = { fg = gh.add_fg, bg = gh.add_cursor_bg              },
          NeogitDiffAddInline       = {                 bg = gh.add_inline_bg, bold = true },

          -- Deletions
          NeogitDiffDelete          = { link = "@diff.minus"                               },
          NeogitDiffDeleteHighlight = {                 bg = gh.del_bg                     },
          NeogitDiffDeleteCursor    = { fg = gh.del_fg, bg = gh.del_cursor_bg              },
          NeogitDiffDeleteInline    = {                 bg = gh.del_inline_bg, bold = true },
        }

        return vim.tbl_extend(
          "force",
          {},
          dark_popup_menus,
          normal_diff,
          neogit_diff
        )
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
