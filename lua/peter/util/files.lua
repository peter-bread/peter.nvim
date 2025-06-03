---@class peter.util.files
---@field strip_extension fun(filename:string,extension?:string):string Remove extension from filename.
---@field get_extension fun(filename:string,extension?:string):string|nil Get extension from filename.
local M = {}

---Remove extension from filename.
---
---If `extension` is given, only remove that extension.
---If the filename does not contain an extension, or does not contain
---the given `extention`, the function will just return `filename`.
---
---### Usage
---
---```lua
--- strip_extension("hello.lua") -- "hello"
--- strip_extension("bye.toml") -- "bye"
---
--- strip_extension("hello.lua", "lua") -- "hello"
--- strip_extension("bye.toml", "lua") -- "bye.toml"
---```
---@param filename string
---@param extension? string
---@return string
function M.strip_extension(filename, extension)
  local pattern = extension and ("%." .. extension .. "$") or "%.%w+$"
  local new_filename = filename:gsub(pattern, "")
  return new_filename
end

---Get extension from filename.
---
---If called with just `filename`, check for any extension. If found, return it.
---Else return `nil`.
---
---If `extension` is provided, only check for that extension.
---
---Since any `string` is "truthy" and `nil` is "falsy", this function can also
---be used to check if a filename has an extension.
---
---### Usage
---
---```lua
--- if has_extension("foo.lua") then
---   -- returns "lua" so does enter the conditonal block
--- done
---
--- if has_extension("bar.toml", "lua") then
---   -- returns nil, so does NOT enter the conditonal block.
--- done
---```
---@param filename string
---@param extension? string
---@return string|nil
function M.get_extension(filename, extension)
  -- use () to capture extension without dot prefix
  local pattern = extension and ("%.(" .. extension .. ")$") or "%.(%w+)$"
  return filename:match(pattern)
end

return M
