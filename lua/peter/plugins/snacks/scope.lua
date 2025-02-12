---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.scope.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      scope = Config,
    },
  },
}
