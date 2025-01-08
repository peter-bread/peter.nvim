return {
  {
    "rose-pine/neovim",
    cond = false,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "auto",
      dark_variant = "main",
      styles = {
        transparency = false,
      },
      highlight_groups = {
        TelescopeBorder = { fg = "overlay", bg = "overlay" },
        TelescopeNormal = { fg = "subtle", bg = "overlay" },
        TelescopeSelection = { fg = "text", bg = "highlight_med" },
        TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
        TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

        TelescopeTitle = { fg = "base", bg = "love" },
        TelescopePromptTitle = { fg = "base", bg = "pine" },
        TelescopePreviewTitle = { fg = "base", bg = "iris" },

        TelescopePromptNormal = { fg = "text", bg = "surface" },
        TelescopePromptBorder = { fg = "surface", bg = "surface" },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      overrides = function(colors)
        ---@module "kanagawa.colors"

        ---@type PaletteColors
        local palette = colors.palette
        ---@type ThemeColors
        local theme = colors.theme

        return {
          -- borderless telescope
          -- stylua: ignore start
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          -- stylua: ignore end

          -- dark menus
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          -- snacks dashboard
          SnacksDashboardHeader = { fg = palette.autumnRed },
          SnacksDashboardFooter = { fg = palette.autumnGreen },
          SnacksDashboardSpecial = { fg = palette.autumnYellow },
          SnacksDashboardDesc = { fg = palette.oldWhite },
          SnacksDashboardIcon = { fg = palette.autumnYellow },

          -- stylua: ignore start
          MiniFilesBorder = { fg = theme.ui.float.bg_border, bg = theme.ui.float.bg_border },
          MiniFilesBorderModified = { fg = theme.diag.warning, bg = theme.ui.float.bg_border },

          MiniIconsGrey = { fg = palette.katanaGray},
          -- stylua: ignore end
        }
      end,
    },
  },
}
