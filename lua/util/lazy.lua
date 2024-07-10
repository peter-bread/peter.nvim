local M = {}

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

return M
