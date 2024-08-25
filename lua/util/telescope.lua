local M = {}

local is_inside_work_tree = {}

---Use git files if in git directory, else use `find_files`.
M.project_files = function()
  local opts = {} -- define opts here

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  local builtin = require("telescope.builtin")

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

M.config = {}

local config_dir = vim.fn.stdpath("config")

---Find language files.
M.config.languages = function()
  local lang_dir = config_dir .. "/lua/plugins/languages"
  require("telescope.builtin").find_files(
    require("telescope.themes").get_dropdown({
      cwd = lang_dir,
      previewer = false,
      layout_config = { height = 0.65 },
    })
  )
end

---Find plugin files (exc. language files).
M.config.plugins = function()
  if vim.fn.executable("fd") == 0 then
    -- TODO: make backup find_command, maybe using `find` or `git ls-files`
    return
  end
  local plugin_dir = config_dir .. "/lua/plugins"
  require("telescope.builtin").find_files({
    cwd = plugin_dir,
    find_command = { "fd", "-I", "-t", "f", "-E", "*languages*" },
  })
end

return M
