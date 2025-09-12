---@class peter.util.keymap
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Safely remove an existing mapping.
---@param modes string|string[]
---@param lhs string
---@param opts? vim.keymap.del.Opts
function M.safe_del(modes, lhs, opts)
  pcall(function()
    vim.keymap.del(modes, lhs, opts)
  end)
end

return M
