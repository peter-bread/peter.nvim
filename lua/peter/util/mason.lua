local M = {}

local mr = require("mason-registry")

local log = vim.schedule_wrap(function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = "Peter Mason" })
  vim.api.nvim_echo({ { msg } }, false, {})
end)

local err = vim.schedule_wrap(function(msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = "Peter Mason" })
  vim.api.nvim_echo({ { msg } }, false, {})
end)

-- TODO: Log when starting an install.

local function install_package(name, on_done)
  local pkg = mr.get_package(name)

  if pkg:is_installed() then
    vim.schedule(on_done)
    return
  end

  pkg:once("install:success", function()
    log(name .. " installed", vim.log.levels.INFO)
    on_done()
  end)

  pkg:once("install:failed", function()
    err(name .. " failed to install")
    on_done()
  end)

  pkg:install()
end

-- ensure packages are installed
-- opts.sync = true  -> blocking
-- opts.sync = false -> async (default)
function M.ensure_installed(packages, opts)
  opts = opts or {}
  local sync = opts.sync or false

  local total = #packages
  local completed = 0
  local done = false

  local function on_done()
    completed = completed + 1
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
