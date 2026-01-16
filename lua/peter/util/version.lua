---@class peter.util.version
local M = {}

---@class peter.util.version.string.Opts
---@field prefix? boolean If true, prepend version number with a "v".

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Get Neovim version as a string.
---
---Optionally prefix with a "v".
---
---Example:
---
--- ```lua
--- local version = require("peter.util.version").string()
--- -- "0.11.4"
---
--- local version = require("peter.util.version").string({ prefix = true })
--- -- "v0.11.4"
---
--- ```
---
---@param opts? peter.util.version.string.Opts
---@return string version Neovim version
function M.string(opts)
  ---@type peter.util.version.string.Opts
  local defaults = { prefix = false }

  ---@type peter.util.version.string.Opts
  opts = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  local v = vim.version()
  local ret = table.concat({ v.major, v.minor, v.patch }, ".")
  return (opts.prefix and "v" or "") .. ret
end

return M
