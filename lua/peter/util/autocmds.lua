local M = {}

---Create autocmd group with `peter_` as a prefix
---@param name string Name of augroup
M.augroup = function(name)
  return vim.api.nvim_create_augroup("peter_" .. name, { clear = true })
end

return M
