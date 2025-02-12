---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.dim.Config
local Config = {
  enabled = true,
  animate = {
    enabled = false,
  },
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      dim = Config,
    },
  },
}
