---@param file string
---@return boolean
local function is_valid_module(file)
  -- We could use `vim.filetype.match({ filename = file })` but this would allow
  -- files like `go.lua.bak`, which should not be included in the actual config
  -- as they are backups.
  return file:sub(-4) == ".lua" and file ~= "init.lua"
end

---@class peter.lang.config
---@field lsp? string[] List of LSP servers to be enabled.
---@field plugins? LazyPluginSpec[] Plugins to be installed.
---@field ftplugin? peter.lang.config.ftplugin Buffer-specific options and config.

---@class peter.lang.config.ftplugin
---@field ft string|string[] Filetype(s) to run `callback` on.
---@field callback fun(args: vim.api.keyset.create_autocmd.callback_args)

---Mapping of programming languages to their respective configurations.
---@type table<string, peter.lang.config>
local M = {}

local languages_dir = vim.fn.stdpath("config") .. "/lua/peter/languages"
local files = require("peter.util.files")

for filename, typ in vim.fs.dir(languages_dir) do
  if typ == "file" and is_valid_module(filename) then
    local lang_name = files.strip_extension(filename)

    ---@type boolean, peter.lang.config
    local ok, cfg = pcall(require, "peter.languages." .. lang_name)

    if ok and type(cfg) == "table" then
      M[lang_name] = cfg
    end
  end
end

return M
