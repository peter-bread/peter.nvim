---@module "lazy"
---@diagnostic disable: missing-fields, unused-local

-- colorscheme
-- https://github.com/rebelot/kanagawa.nvim

---@type LazyPluginSpec[]
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,

    ---@type KanagawaConfig
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },

      ---@param colors KanagawaColors
      overrides = function(colors)
        local palette = colors.palette
        local theme = colors.theme

        return {
          -- dark popup menus
          Pmenu = { bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
