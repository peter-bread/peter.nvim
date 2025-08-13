---@module "lazy"
---@module "snacks"

-- Pretty `vim.notify`.
-- See 'https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md'.

local P = require("peter.util.plugins.plugins")

---@type snacks.notifier.Config
---@diagnostic disable-next-line: missing-fields
local cfg = {
  timeout = 5000,
  style = "compact",
  sort = { "added" },
}

---@type LazyPluginSpec[]
return {
  P.snacks({ notifier = cfg }),
}
