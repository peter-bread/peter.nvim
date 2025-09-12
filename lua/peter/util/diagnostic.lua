---@class peter.util.diagnostic
local M = {}

local H = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

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

---Get diagnostics for current line.
---@return vim.Diagnostic[]
function M.current_line()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  return vim.diagnostic.get(bufnr, { lnum = line })
end

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ---------- END OF API FUNCTIONS. START OF HELPER FUNCTIONS. ---------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Set `JumpOpts` for `vim.diagnostic.jump`.
---Set `count` separately from the rest of `opts`.
---@param count integer Number of diagnostics to move by.
---@param opts? vim.diagnostic.JumpOpts
---@return vim.diagnostic.JumpOpts
function H.jump_opts(count, opts)
  return vim.tbl_extend("force", { count = count }, opts or {})
end

return M
