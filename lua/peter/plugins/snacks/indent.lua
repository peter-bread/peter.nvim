---@module "snacks"

local P = require("peter.util.plugins.plugins")

---@type snacks.indent.Config
---@diagnostic disable-next-line: missing-fields
local cfg = {
  animate = { enabled = false },
}

return {
  P.snacks({ indent = cfg }),
}
