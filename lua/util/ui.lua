local M = {}

function M.toggle_background()
  if vim.opt.background:get() == "light" then
    vim.opt.background = "dark"
  else
    vim.opt.background = "light"
  end
end

return M
