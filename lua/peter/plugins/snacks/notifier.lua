---@module "snacks"

local P = require("peter.util.plugins.plugins")

---@type snacks.notifier.Config
---@diagnostic disable-next-line: missing-fields
local cfg = {
  timeout = 5000,
  style = "compact",
  sort = { "added" },
}

return {
  P.snacks({ notifier = cfg }),
}
