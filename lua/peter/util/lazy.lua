---@class peter.util.lazy
local M = {}

-- What is the difference between these?
-- local x = require("lazy.core.config").plugins[plugin]
-- local y = require("lazy.core.config").spec.plugins[plugin]

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
  if M.is_loaded(name) then
    fn()
  else
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
end

return M
