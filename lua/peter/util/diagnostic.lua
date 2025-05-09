---@class peter.util.diagnostic
---@field jump fun(opts:vim.diagnostic.JumpOpts):(vim.Diagnostic?) Move to diagnostic.
---@field next fun(opts:vim.diagnostic.JumpOpts):(vim.Diagnostic?) Move to next diagnostic.
---@field prev fun(opts:vim.diagnostic.JumpOpts):(vim.Diagnostic?) Move to previous diagnostic.
local M = {}

---Move to a diagnostic.
---
---This is just a wrapper around the builtin
---`vim.diagnostic.jump` function.
---@param opts vim.diagnostic.JumpOpts
---@return (vim.Diagnostic)?
function M.jump(opts)
  return vim.diagnostic.jump(opts)
end

---Move to next diagnostic.
---@param opts? vim.diagnostic.JumpOpts
---@return (vim.Diagnostic)?
function M.next(opts)
  return M.jump(vim.tbl_extend("force", { count = 1 }, opts or {}))
end

---Move to previous diagnostic.
---@param opts? vim.diagnostic.JumpOpts
---@return (vim.Diagnostic)?
function M.prev(opts)
  return M.jump(vim.tbl_extend("force", { count = -1 }, opts or {}))
end

return M
