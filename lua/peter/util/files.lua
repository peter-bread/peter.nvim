local M = {}

---@param filename string
---@param extension? string
---@return string
---
--- Remove extension from filename.
--- If `extension` is given, only remove that extension.
---
--- # Usage
---
---```lua
--- strip_extension("hello.lua") -- "hello"
--- strip_extension("bye.toml") -- "bye"
---
--- strip_extension("hello.lua", "lua") -- "hello"
--- strip_extension("bye.toml", "lua") -- "bye.toml"
--- ```
M.strip_extension = function(filename, extension)
  local pattern = extension and ("%." .. extension .. "$") or "%.%w+$"
  return (filename:gsub(pattern, "")) -- only return first value
end

---Gets the first non-nil filepath.
---Useful when checking multiple environemnt variables that may not be set.
---@param values string[][]
---@return string|nil
M.first_non_nil_path = function(values)
  for _, path_table in ipairs(values) do
    local path = M.safe_concat_path(path_table)
    if path then
      return path
    end
  end
  return nil
end

---Safely concatenate a filepath
---
---Usage:
---
--- ```lua
--- -- if $XDG_CONFIG_HOME = $HOME/.config
--- safe_concat_path({ vim.fn.getenv("XDG_CONFIG_HOME"), "gh" }) -- /home/username/.config/gh
---
--- -- if $XDG_CONFIG_HOME is not set
--- safe_concat_path({ vim.fn.getenv("XDG_CONFIG_HOME"), "gh" }) -- nil
--- ```
---@param list string[]
---@return string|nil
M.safe_concat_path = function(list)
  for _, term in ipairs(list) do
    if term == vim.NIL or term == nil then
      return nil
    end
  end
  return vim.fs.normalize(table.concat(list, "/"))
end

return M
