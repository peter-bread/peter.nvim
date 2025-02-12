---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.terminal.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      terminal = Config,
    },
  },
}
