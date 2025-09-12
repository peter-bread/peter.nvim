---@module "lazy"
---@module "snacks"

-- Toggle keymaps integrated with 'which-key.nvim'.
-- See 'https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md'.

local P = require("peter.util.plugins.plugins")

---@type snacks.toggle.Config
---@diagnostic disable-next-line: missing-fields
local cfg = {
  enabled = true,
}

---@type LazyPluginSpec[]
return {
  P.snacks({ toggle = cfg }),
}
