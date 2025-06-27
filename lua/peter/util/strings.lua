---@class peter.util.strings
local M = {}

---Capitalise a word.
---First letter will be uppercase, all others lowercase.
---@param word string
---@return string
function M.capitalise(word)
  if type(word) ~= "string" then
    return ""
  end
  return word:sub(1, 1):upper() .. word:sub(2):lower()
end

return M
