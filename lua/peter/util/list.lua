---@class peter.util.list
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Removes duplicate values from a list-like table without modifying the original
---table.
---
---The input table is not modified. A new table is created by this function.
---
---For in-place deduplication, see `:h vim.list.unique`.
---
---@generic T
---@param t T[]
---@return T[] t A new, deduplicated list.
function M.uniq_copy(t)
  return vim.list.unique(vim.deepcopy(t))
end

return M
