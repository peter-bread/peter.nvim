---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.notifier.Config
local Config = {
  enabled = true,
  timeout = 5000,
  style = "compact",
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
