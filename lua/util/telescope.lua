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
---
---This displays a list of configured languages to choose from.
---The `.lua` extensions have been removed to make it clearer and to make
---searching easier.
M.config.languages = function()
  local utils = require("telescope.utils")

  local function strip_extension(filename)
    return filename:gsub("%.%w+$", "")
  end

  local lang_dir = config_dir .. "/lua/plugins/languages"

  -- Custom entry maker that strips the extensions
  local function custom_entry_maker(entry)
    local tail = utils.path_tail(entry)
    local absolute_path = lang_dir .. "/" .. tail
    local filename_without_ext = strip_extension(tail)
    return {
      value = absolute_path,
      display = filename_without_ext, -- text being displayed
      ordinal = filename_without_ext, -- text for filtering
    }
  end

  require("telescope.builtin").find_files(
    require("telescope.themes").get_dropdown({
      prompt_title = "Language Config Files",
      cwd = lang_dir,
      previewer = false,
      layout_config = { height = 0.65, width = 0.2 },
      entry_maker = custom_entry_maker,
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

    -- fd -I -t f -E *languages*
    find_command = {
      "fd",
      "--no-ignore",
      "--type",
      "file",
      "--exclude",
      "*languages*",
    },
  })
end

return M
