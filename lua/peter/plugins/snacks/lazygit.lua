---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.lazygit.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      lazygit = Config,
    },
  },
}
