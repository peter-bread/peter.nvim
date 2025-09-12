---@class peter.util.buffer
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Check if a buffer is editable.
---@param bufnr? integer Buffer to check. If no value is provided, the current buffer is used.
---@return boolean is_editable
function M.can_edit(bufnr)
  -- TODO: Check if there are better ways to do this.
  bufnr = bufnr or 0
  return vim.api.nvim_buf_get_name(bufnr) ~= ""
    and vim.bo[bufnr].buftype == ""
    and vim.bo[bufnr].modifiable
end

return M
