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

        -- stylua: ignore
        return {
          -- Dark popup menus.
          Pmenu                     = {                 bg = theme.ui.bg_p1 },
          PmenuSel                  = { fg = "NONE",    bg = theme.ui.bg_p2 },
          PmenuSbar                 = {                 bg = theme.ui.bg_m1 },
          PmenuThumb                = {                 bg = theme.ui.bg_p2 },

          -- Neogit Diff (better for colourblindness).
          NeogitDiffAdd             = { fg = "#3a5ea1", bg = "#15223a" },
          NeogitDiffDelete          = { fg = "#946359", bg = "#2d1e1b" },
          NeogitDiffAddHighlight    = {                 bg = "#15223a" },
          NeogitDiffDeleteHighlight = {                 bg = "#2d1e1b" },
          NeogitDiffAddCursor       = {                 bg = "#234d87" },
          NeogitDiffDeleteCursor    = {                 bg = "#733d22" },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
