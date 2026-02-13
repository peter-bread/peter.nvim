---@class peter.util.neovim
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Check if current working directory is in Neovim config directory.
---@return boolean
function M.is_in_neovim_config_dir()
  local cwd = vim.fn.getcwd()
  local config = vim.fn.stdpath("config")

  return cwd:sub(1, #config) == config
end

return M
