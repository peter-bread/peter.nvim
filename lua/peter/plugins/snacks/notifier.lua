---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.notifier.Config
local Config = {
  enabled = true,
  style = "minimal",
}

return {
  {
    "folke/snacks.nvim",

    ---@param opts snacks.Config
    opts = function(_, opts)
      opts.notifier = Config
    end,
  },
}
