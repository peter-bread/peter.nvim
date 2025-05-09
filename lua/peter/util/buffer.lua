---@class peter.util.buffer
---@field can_edit fun(bufnr?:peter.core.bufnr):boolean
local M = {}

---Check if a buffer is editable.
---@param bufnr? peter.core.bufnr Buffer to check.
---@return boolean editable
function M.can_edit(bufnr)
  bufnr = bufnr or 0
  return vim.bo[bufnr].buftype == ""
    and vim.api.nvim_buf_get_name(bufnr) ~= ""
    and vim.api.nvim_get_option_value("modifiable", { buf = bufnr })
end

return M
