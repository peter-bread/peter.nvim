---@class peter.util.table
---@field without fun(tbl:table,keys:string[]):table
local M = {}

---Return a copy of `tbl` with `keys` removed.
---@param tbl table Original table.
---@param keys string[] Keys to be removed.
---@return table
function M.without(tbl, keys)
  local ret = {}
  for k, v in pairs(tbl) do
    if not keys[k] then
      ret[k] = v
    end
  end
  return ret
end

return M
