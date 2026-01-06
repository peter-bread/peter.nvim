---@class peter.util.lazy
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Try to get a plugin by `name`.
---@param name string
---@return LazyPlugin | nil
function M.get_plugin(name)
  return require("lazy.core.config").plugins[name]
end

---Check whether a plugin `name` is included in the final spec.
---@param name string
---@return boolean
function M.is_in_spec(name)
  return M.get_plugin(name) ~= nil
end

---Check whether a plugin `name` has been loaded by 'lazy.nvim'.
---@param name string
---@return ({ [string]: string }|{ time: number }) | nil
function M.is_loaded(name)
  local plugin = M.get_plugin(name)

  -- TODO: Should this distinguish between a plugin not being loaded and a
  -- plugin not being in the spec?
  return plugin and plugin._.loaded
end

---Run `fn` if `name` is already loaded or when it loads.
---@param name string
---@param fn fun()
function M.on_load(name, fn)
  local plugin = M.get_plugin(name)

  -- Do nothing if the plugin is not in the spec.
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
