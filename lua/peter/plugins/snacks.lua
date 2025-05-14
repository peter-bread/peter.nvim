---@module "lazy"
---@module "snacks"

-- QoL plugins
--

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
    init = function()
    end,
  }
}
