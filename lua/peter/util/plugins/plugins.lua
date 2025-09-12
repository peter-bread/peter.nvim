---@module "which-key"
---@module "snacks"
---@module "blink-cmp"

---@class peter.util.plugins.plugins
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Add which-key keymap groups.
---Plugin: [which-key.nvim](https://github.com/folke/which-key.nvim).
---
---Use this when the groups being added are part of lazy-loading keymaps,
---i.e. the plugin spec uses the `keys` field. This is because the group
---descriptions should be availble *before* the plugin loads.
---
---
---Usage:
---
---```lua
--- local P = require("peter.util.plugins.plugins")
---
--- return {
---   {
---     "some/plugin.nvim",
---     keys = {
---       { "<leader>cz", ... },
---     },
---   },
---   P.which_key({
---     mode = { "n" },
---     { "<leader>c", group = "code" },
---   }),
--- }
---```
---
---If groups or descriptions should only appear *after* a plugin is loaded,
---use the following snippet in that plugin's `config` field:
---
---```lua
--- require("peter.util.lazy").on_load("plugin.nvim", function()
---   require("which-key").add({
---     mode = { ... },
---     { ... },
---   })
--- end)
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

---Add completion sources.
---Plugin: [blink.cmp](https://github.com/Saghen/blink.cmp).
---@param sources blink.cmp.SourceConfigPartial
---@return LazyPluginSpec
function M.blink(sources)
  return {
    "Saghen/blink.cmp",
    optional = true,
    opts = { sources = sources or {} },
  }
end

return M
