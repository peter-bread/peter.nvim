---@module "which-key"
---@module "snacks"

---@class peter.util.plugins.plugins
---@field which_key fun(spec:wk.Spec):LazyPluginSpec
local M = {}

---Add which-key keymap groups.
---Plugin: [which-key.nvim](https://github.com/folke/which-key.nvim).
---
---Usage:
---
---```lua
--- local P = require("peter.util.plugins.plugins")
---
--- return {
---   P.which_key({
---     mode = { "n" },
---     { "<leader>c", group = "code" },
---   }),
--- }
---```
---@param spec wk.Spec
---@return LazyPluginSpec
function M.which_key(spec)
  return {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = { spec },
    },
  }
end

---Add snacks module.
---Plugin: [snacks.nvim](https://github.com/folke/snacks.nvim)
---
---Usage:
---
---```lua
--- local P = require("peter.util.plugins.plugins")
---
--- ---@type snacks.notifier.Config
--- local cfg = {
---   enabled = true,
---   timeout = 5000,
---   style = "compact",
---   sort = { "added" },
--- }
---
--- return {
---   P.snacks({ notifier = cfg })
--- }
---```
---@param opts snacks.Config
---@param keys? LazyKeysSpec[]
---@return LazyPluginSpec
function M.snacks(opts, keys)
  ---@type LazyPluginSpec
  return {
    "folke/snacks.nvim",
    optional = true,
    opts = opts,
    keys = keys,
  }
end

return M
