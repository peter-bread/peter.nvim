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

    ---@param opts snacks.Config
    opts = function(_, opts)
      opts.dim = Config
    end,
  },
}
