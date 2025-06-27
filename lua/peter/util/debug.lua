---@class peter.util.debug
local M = {}

---Pretty-print any value.
---@param ... any Value to print.
function M.pp(...)
  print(vim.inspect(...))
end

return M
