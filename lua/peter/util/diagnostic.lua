---@class peter.util.diagnostic
local M = {}

local H = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

function M.get_default_config()
  local icons = require("peter.util.icons").diagnostics

  ---@type vim.diagnostic.Opts
  return {
    float = {
      source = true,
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.Error,
        [vim.diagnostic.severity.WARN] = icons.Warn,
        [vim.diagnostic.severity.INFO] = icons.Info,
        [vim.diagnostic.severity.HINT] = icons.Hint,
      },
    },
    virtual_text = {
      prefix = "●",
      source = false,
      spacing = 4,
    },
    virtual_lines = false,
  }
end

function M.set_default_config()
  vim.diagnostic.config(M.get_default_config())
end

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

---Get diagnostics for the current line in the current buffer (in the current
---window).
---@return vim.Diagnostic[]
function M.line_diagnostics()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  return vim.diagnostic.get(0, { lnum = line })
end

local function is_enabled()
  local config = vim.diagnostic.config(nil)
  return config.virtual_lines ~= false and config.virtual_text == false
end

function M.toggle_virtual_lines(opts)
  opts = opts or {}

  if is_enabled() then
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = true,
    })
    return
  end

  if opts.exit_early and opts.exit_early() then
    return
  end

  vim.diagnostic.config({
    virtual_lines = opts.virtual_lines or true,
    virtual_text = false,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = 0,
    once = true,
    callback = function()
      vim.diagnostic.config({
        virtual_lines = false,
        virtual_text = true,
      })
    end,
  })
end

-- ---@class ToggleState
-- ---@field is_enabled boolean
-- ---@field reset fun()
-- local ToggleState = {}
--
-- -- Stores whether virtual line diagnostics are enabled.
-- ToggleState.is_enabled = false
--
-- ---Closure that resets buffer diagnostics and toggles the state of the
-- ---diagnostics.
-- ToggleState.reset = function()
--   vim.diagnostic.hide(nil, 0)
--   vim.diagnostic.show(nil, 0)
--   ToggleState.is_enabled = false
-- end
--
-- ---@class peter.util.diagnostic.ToggleVirtualLines.Opts
-- ---@field exit_early? fun():boolean
-- ---@field virtual_lines? boolean | (fun(namespace: integer, bufnr: integer):vim.diagnostic.Opts.VirtualLines) | vim.diagnostic.Opts.VirtualLines
--
-- ---comment
-- ---@param opts? peter.util.diagnostic.ToggleVirtualLines.Opts
-- function M.toggle_virtual_lines(opts)
--   if ToggleState.is_enabled then
--     ToggleState.reset()
--     return
--   end
--
--   opts = opts or {}
--
--   if opts.exit_early and opts.exit_early() then
--     return
--   end
--
--   vim.diagnostic.hide(nil, 0)
--   vim.diagnostic.show(nil, 0, nil, {
--     virtual_lines = opts.virtual_lines and opts.virtual_lines
--       or { current_line = true },
--     virtual_text = false,
--   })
--
--   ToggleState.is_enabled = true
--
--   vim.api.nvim_create_autocmd("CursorMoved", {
--     buffer = 0,
--     callback = function()
--       ToggleState.reset()
--       return true -- Delete autocmd after executing.
--     end,
--   })
-- end
--
-- function M.toggle_virtual_lines_current_line()
--   M.toggle_virtual_lines({
--     exit_early = function()
--       return vim.tbl_isempty(M.line_diagnostics())
--     end,
--   })
-- end

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
