local Constants = require("peter.constants")
local Paths = Constants.paths

---@class CustomTelescopePickers
---Lua module containing custom telescope pickers.
local M = {}

local is_inside_work_tree = {}

---Use `git_files` if in git directory, else fallback to `find_files`.
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

M.find_all_files = function()
  require("telescope.builtin").find_files({
    hidden = true,
  })
end

---@class CustomTelescopeConfigPickers
---Table of telescope picker categories that search inside neovim config directory.
M.config = {}

---@class CustomEntryMakers
---Table of custom entry makers.
---Some are actual entry maker functions,
---others are wrappers that return entry maker functions.
local entry_makers = {}

---(Wrapper) Creates an entry maker that ignores file extensions.
---@param cwd string Same as `cwd` in e.g. `builtin.find_files`.
---@param ext? string Extension to ignore. If `nil` then applies to any extension.
---@return fun(entry:string):table
---@type fun(cwd:string, ext?:string):fun(entry:string)
entry_makers.remove_file_extensions = function(cwd, ext)
  return function(entry)
    local absolute_path = cwd .. "/" .. entry
    local filename = require("telescope.utils").path_tail(entry)
    local escaped_filenamne = filename:gsub("([%^%$%(%)%%[%]_%+%-%?])", "%%%1")
    local filename_without_ext =
      require("peter.util.files").strip_extension(escaped_filenamne, ext)
    local relative_path =
      entry:gsub(escaped_filenamne .. "$", filename_without_ext)
    return {
      value = absolute_path, -- Full absolute path for opening the file
      display = relative_path, -- Display path with the filename's extension removed
      ordinal = relative_path, -- Text for filtering
    }
  end
end

---@class CustomTelescopeConfigFilePickers
---Table of telescope pickers to find files in neovim config directory.
M.config.find_files = {}

---Find files in neovim config directory.
M.config.find_files.find_files = function()
  require("telescope.builtin").find_files({
    prompt_title = "Config Files",
    cwd = Paths.config,
  })
end

---Find language files in neovim config directory.
---
---This displays a list of configured languages to choose from.
---The `.lua` extensions have been removed to make it clearer and to make
---searching easier.
M.config.find_files.languages = function()
  local lang_dir = Paths.languages

  require("telescope.builtin").find_files(
    require("telescope.themes").get_dropdown({
      prompt_title = "Language Config Files",
      cwd = lang_dir,
      previewer = false,
      layout_config = { height = 0.65, width = 0.2 },
      entry_maker = entry_makers.remove_file_extensions(lang_dir, "lua"),
    })
  )
end

---Find plugin files (exc. language files) in neovim config directory.
M.config.find_files.plugins = function()
  local plugin_dir = Paths.plugins

  require("telescope.builtin").find_files({
    prompt_title = "Plugin Files",
    cwd = plugin_dir,
    entry_maker = entry_makers.remove_file_extensions(plugin_dir, "lua"),

    layout_config = {
      horizontal = {
        results_width = 0.3,
        preview_width = 0.7,
      },
    },

    find_command = {
      "rg",
      "--color",
      "never",
      "--files",
      "--hidden",
      "--no-ignore",
      "--glob",
      "!*languages*",
      "--glob",
      "!*.temp",
      "--glob",
      "!*.temp.*",
      "--glob",
      "!temp.*",
    },
  })
end

---Find temporary files in neovim config directory.
M.config.find_files.temps = function()
  require("telescope.builtin").find_files({
    cwd = Paths.config,
    prompt_title = "Temp Files",
    find_command = {
      "rg",
      "--color",
      "never",
      "--files",
      "--hidden",
      "--no-ignore",
      "--glob",
      "temp/*",
      "--glob",
      "temp.*",
      "--glob",
      "*.temp.*",
      "--glob",
      "*.temp",
    },

    layout_config = {
      horizontal = {
        results_width = 0.5,
        preview_width = 0.5,
      },
    },
  })
end

---Find files in `after/ftplugin` in neovim config directory.
M.config.find_files.after_ftplugin = function()
  local ftplugin_dir = Paths.config .. "/after/ftplugin"

  require("telescope.builtin").find_files({
    prompt_title = "`after/ftplugin` Files",
    cwd = ftplugin_dir,
    entry_maker = entry_makers.remove_file_extensions(ftplugin_dir, "lua"),

    layout_config = {
      horizontal = {
        results_width = 0.3,
        preview_width = 0.7,
      },
    },
  })
end

return M
