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

return M
