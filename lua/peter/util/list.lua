---@class peter.util.list
---@field uniq fun(list:any[]):any[] Remove duplicate elements from a list.
local M = {}

---Remove duplicate elements from a list.
---@param list any[] List to remove duplicates from.
---@return any[] new_list List with duplicates removed.
function M.uniq(list)
  local hash = {}
  local ret = {}

  for _, v in ipairs(list) do
    if not hash[v] then
      ret[#ret + 1] = v
      hash[v] = true
    end
  end

  return ret
end

return M
