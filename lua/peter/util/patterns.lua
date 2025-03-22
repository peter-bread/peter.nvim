local M = {}

---Check that a string matches a list of patterns and doesn't match another list of patterns.
---@param string string String to match
---@param match_patterns string[] Patterns that `string` should match
---@param exclude_patterns string[] Patterns that `string` should *NOT* match
---@return boolean match Whether the string satifies the patterns
M.matches_all = function(string, match_patterns, exclude_patterns)
  local matches = false
  for _, pattern in ipairs(match_patterns) do
    if string:match(pattern) then
      matches = true
      break
    end
  end

  if not matches then
    return false
  end

  for _, pattern in ipairs(exclude_patterns) do
    if string:match(pattern) then
      return false
    end
  end

  return true
end

M.get_sensitive_message = function(path)
  local sensitive = require("peter.constants").paths.sensitive
  for _, value in pairs(sensitive) do
    if M.matches_all(path, value.match, value.exclude) then
      return value.message
    end
  end
  return nil
end

return M
