---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.notifier.Config
local Config = {
  enabled = true,
  style = "minimal",
  sort = { "added" },
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      notifier = Config,
    },
  },
}
