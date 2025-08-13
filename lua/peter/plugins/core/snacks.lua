---@module "lazy"
---@module "snacks"

-- Collection of QoL plugins.
-- See 'https://github.com/folke/snacks.nvim'.
--
-- Each plugin is configured in its own file.
-- These can be found in `lua/peter/plugins/snacks/<plugin>.lua`.

---@type LazyPluginSpec[]
return {
  {
    "folke/snacks.nvim",
    priority = 950,
    lazy = false,

    ---@type snacks.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {},
    keys = {},
    init = function() end,
  },
}
