local M = {}

-- most functions here are from or inspired by LazyVim:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local config = require("lazy.core.config")
  if config.plugins[name] and config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

---Get a Lazy plugin spec
---@param name string Name of plugin
---@return LazyPlugin spec Plugin spec
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---Get a property from a plugin spec
---@param plugin_name string Name of plugin
---@param prop_name string Name of property
---@return table prop Value of the property
function M.get_prop(plugin_name, prop_name)
  local plugin = M.get_plugin(plugin_name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, prop_name)
end

---Get the `opts` property from a plugin spec
---@param plugin_name string Name of plugin
---@return table opts Opts table for the plugin
function M.opts(plugin_name)
  return M.get_prop(plugin_name, "opts")
end

return M
