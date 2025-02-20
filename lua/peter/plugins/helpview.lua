---@module "helpview"

return {
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    priority = 900,

    ---@type helpview.config
    opts = {
      preview = {
        icon_provider = "mini",
      },
    },
  },
}
