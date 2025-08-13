---@module "lazy"
---@module "snacks"

-- Indent guides and scopes.
-- See 'https://github.com/folke/snacks.nvim/blob/main/docs/indent.md'.

local P = require("peter.util.plugins.plugins")

---@type snacks.indent.Config
---@diagnostic disable-next-line: missing-fields
local cfg = {
  animate = { enabled = false },
}

---@type LazyPluginSpec[]
return {
  P.snacks({ indent = cfg }),
}
