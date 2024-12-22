---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.toggle.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@param opts snacks.Config
    opts = function(_, opts)
      opts.toggle = Config
    end,
  },
}
