---@class peter.util.diagnostic
---@field jump fun(opts:vim.diagnostic.JumpOpts):(vim.Diagnostic?) Move to diagnostic.
---@field next fun(opts:vim.diagnostic.JumpOpts):(vim.Diagnostic?) Move to next diagnostic.
---@field prev fun(opts:vim.diagnostic.JumpOpts):(vim.Diagnostic?) Move to previous diagnostic.
local M = {}

---@class peter.util.diagnostic.hidden
---@field jump_opts fun(count:integer, opts?:vim.diagnostic.JumpOpts):vim.diagnostic.JumpOpts Set `count` separately to rest of `opts`.
local H = {}

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
  return M.jump(H.jump_opts(vim.v.count1, opts))
end

---Move to previous diagnostic.
---@param opts? vim.diagnostic.JumpOpts
---@return (vim.Diagnostic)?
function M.prev(opts)
  return M.jump(H.jump_opts(-vim.v.count1, opts))
end

---Set `JumpOpts` for `vim.diagnostic.jump`.
---Set `count` separately from the rest of `opts`.
---@param count integer Number of diagnostics to move by.
---@param opts? vim.diagnostic.JumpOpts
---@return vim.diagnostic.JumpOpts
function H.jump_opts(count, opts)
  return vim.tbl_extend("force", { count = count }, opts or {})
end

return M
