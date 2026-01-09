local M = {}

local mr = require("mason-registry")

---@param msg string
---@param level vim.log.levels
local _log = function(msg, level)
  if not vim.g.is_headless then
    vim.notify(msg, level, { title = "Mason Forge" })
  else
    vim.api.nvim_echo({ { msg }, { "\n" } }, false, {})
  end
end

local log_i = vim.schedule_wrap(function(msg)
  _log(msg, vim.log.levels.INFO)
end)

local log_e = vim.schedule_wrap(function(msg)
  _log(msg, vim.log.levels.ERROR)
end)

-- TODO: Log when starting an install.

local function install_package(name, on_done)
  local pkg = mr.get_package(name)

  if pkg:is_installed() then
    vim.schedule(on_done)
    return
  end

  pkg:once("install:success", function()
    log_i(name .. " installed", vim.log.levels.INFO)
    on_done()
  end)

  pkg:once("install:failed", function()
    log_e(name .. " failed to install")
    on_done()
  end)

  if not pkg:is_installing() then
    pkg:install()
  end
end

function M.ensure_installed(packages, opts)
  opts = opts or {}
  local sync = vim.g.is_headless

  local total = #packages
  local completed = 0
  -- TODO: Count any installations that were skipped, because the package was
  -- already installed/installing.
  local skipped = 0
  local done = false

  local function on_done(did_skip)
    if did_skip then
      skipped = skipped + 1
    else
      completed = completed + 1
    end

    if completed >= total then
      done = true
    end
  end

  local function run()
    for _, name in ipairs(packages) do
      install_package(name, on_done)
    end
  end

  -- refresh registry first if needed
  if mr.refresh then
    mr.refresh(run)
  else
    run()
  end

  -- synchronous mode
  if sync then
    vim.wait(10000, function()
      return done
    end)
  end
end

return M
