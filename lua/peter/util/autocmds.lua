-- Utility functions for autocmds

local M = {}

---Create augroup with "Peter" as a prefix
---@param name string Name of augroup
---@return integer id id of the created group
function M.augroup(name)
  return vim.api.nvim_create_augroup("Peter" .. name, { clear = true })
end

return M
