---@class peter.util.files
---@field strip_extension fun(filename:string,extension?:string):string
local M = {}

---@param filename string
---@param extension? string
---@return string
---
--- Remove extension from filename.
--- If `extension` is given, only remove that extension.
--- If the filename does not contain an extension, or does not contain
--- the given `extention`, the function will just return `filename`.
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
function M.strip_extension(filename, extension)
  local pattern = extension and ("%." .. extension .. "$") or "%.%w+$"
  local new_filename = filename:gsub(pattern, "")
  return new_filename
end

return M
