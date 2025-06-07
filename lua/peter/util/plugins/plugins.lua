---@module "which-key"

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

return M
