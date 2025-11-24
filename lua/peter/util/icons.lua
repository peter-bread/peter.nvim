---@class peter.util.icons
local M = {}

-- stylua: ignore
M.diagnostics = {
  Error = " ",
  Warn  = " ",
  -- Hint  = " ",
  Hint  = " ",
  Info  = " ",
}

-- stylua: ignore
M.git = {
  added     = " ",
  modified  = " ",
  removed   = " ",
  ignored   = " ",
  renamed   = " ",
}

-- stylua: ignore
M.kinds = {}

function M.try_mock_nvim_web_devicons()
  local ok, icons = pcall(require, "mini.icons")
  if ok then
    icons.mock_nvim_web_devicons()
  else
    vim.notify(
      "Failed to mock nvim web devicons",
      vim.log.levels.ERROR({ title = "Mini Icons" })
    )
  end
end

return M
