---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.toggle.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      toggle = Config,
    },
  },
}
