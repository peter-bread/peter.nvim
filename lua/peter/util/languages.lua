---@class peter.util.languages
---@field for_each fun(fn:fun(name:string, cfg:peter.lang.config))
local M = {}

---Run `fn` on all language configs.
---@param fn fun(name:string, cfg:peter.lang.config) Function to run for each language.
function M.for_each(fn)
  for name, cfg in pairs(require("peter.languages") or {}) do
    fn(name, cfg)
  end
end

return M
