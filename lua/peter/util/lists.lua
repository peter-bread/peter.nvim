local M = {}

---Remove duplicate values from a list
---@param list any[] List to remove duplicates from
---@return any[] new_list List with duplicates removed
M.remove_duplicates = function(list)
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
