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

function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

function M.get_prop(name, prop)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, prop)
end

function M.opts(name)
  return M.get_prop(name, "opts")
end

return M
