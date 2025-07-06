---@class peter.util.lazy
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Check whether a `plugin` has been loaded by lazy.nvim.
---@param plugin string
---@return ({ [string]: string }|{ time: number }) | nil
function M.is_loaded(plugin)
  local config = require("lazy.core.config")
  return config.plugins[plugin] and config.plugins[plugin]._.loaded
end

---Run `fn` if `name` is already loaded or when it loads.
---@param name string
---@param fn function
function M.on_load(name, fn)
  local plugin = require("lazy.core.config").plugins[name]

  -- do nothing if the plugin is not in the spec
  if not plugin then
    return
  end

  if plugin._.loaded then
    fn()
    return
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(ev)
      if ev.data == name then
        fn()
        return true
      end
    end,
  })
end

return M
