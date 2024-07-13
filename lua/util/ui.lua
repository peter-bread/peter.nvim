local M = {}

function M.toggle_background()
  local o = vim.opt
  if o.background:get() == "light" then
    o.background = "dark"
  else
    o.background = "light"
  end
end

return M
