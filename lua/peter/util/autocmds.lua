---@class peter.util.autocmds
---@field augroup fun(name:string):integer Create an augroup in the "Peter" namespace.
local M = {}

---Create an augroup in the "Peter" namespace.
---@param name string Name of augroup
---@return integer id ID of the created group
function M.augroup(name)
  return vim.api.nvim_create_augroup("Peter" .. name, { clear = true })
end

return M
