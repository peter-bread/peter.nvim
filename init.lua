if vim.fn.has("nvim-0.11") ~= 1 then
  vim.notify_once(
    "peter.nvim requires Neovim 0.11 or above. "
      .. "Current version: "
      .. require("peter.util.version").string()
      .. ". "
      .. "Upgrade if possible."
      .. "\n"
      .. "Altervatively, checkout an older tagged version of the config (not recommended).",
    vim.log.levels.ERROR
  )
  return
end

require("peter.config")

-- local toggle_virtual_text = function()
--   local current_config = vim.diagnostic.config().virtual_text
--   local new_config
--
--   if current_config then
--     new_config = false
--   else
--     new_config =
--       require("peter.util.diagnostic").get_default_config().virtual_text
--   end
--
--   vim.diagnostic.config({ virtual_text = new_config })
-- end

-- local toggle_virtual_lines = function()
--   local current_config = vim.diagnostic.config().virtual_lines
--   local new_config
--
--   if not current_config then
--     new_config = true
--   else
--     new_config =
--       require("peter.util.diagnostic").get_default_config().virtual_lines
--   end
--
--   vim.diagnostic.config({ virtual_lines = new_config })
-- end

---Toggle `vim.diagnostic[key]` between `enabled` and `false`.
---@param key string
---@param enabled any
local toggle = function(key, enabled)
  local current_config = vim.diagnostic.config()[key]
  local new_config

  if current_config then
    new_config = false
  else
    new_config = enabled
  end

  vim.diagnostic.config({ [key] = new_config })
end

local function toggle_virtual_text()
  local diagnostic = require("peter.util.diagnostic")
  toggle("virtual_text", diagnostic.get_default_config().virtual_text)
end

local function toggle_virtual_lines()
  toggle("virtual_lines", true)
end

local function toggle_virtual_lines_current_line()
  toggle("virtual_lines", { current_line = true })
end

local function s()
  local diagnostic = require("peter.util.diagnostic")

  if vim.tbl_isempty(diagnostic.line_diagnostics()) then
    return
  end

  local function do_toggle()
    toggle_virtual_text()
    toggle_virtual_lines_current_line()
  end

  do_toggle()

  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      do_toggle()
      return true -- Delete autocmd after executing.
    end,
  })
end

vim.keymap.set("n", "<leader>d", function()
  s()
  -- toggle_virtual_text()
  -- toggle_virtual_lines()
end)
