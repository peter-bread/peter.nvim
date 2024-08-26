local M = {}

---@param filename string
---@param extension? string
---@return string
---@return _ ignore_this
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
  if not extension then
    return filename:gsub("%.%w+$", "")
  end
  local pattern = "%." .. extension .. "$"
  return filename:gsub(pattern, "")
end

return M
