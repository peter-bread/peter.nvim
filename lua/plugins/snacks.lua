return {
  "folke/snacks.nvim",
  priority = 900,
  lazy = false,

  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    dashboard = require("plugins.snacks.dashboard"),
  },
}
