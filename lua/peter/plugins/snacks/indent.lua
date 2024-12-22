---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.indent.Config
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
      opts.indent = Config
    end,
  },
}
