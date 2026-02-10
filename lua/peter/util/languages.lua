---@class peter.util.languages
local M = {}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Run `fn` on all language configs.
---@param fn fun(name:string, cfg:peter.lang.Config) Function to run for each language.
function M.for_each(fn)
  local ok, languages = pcall(require, "peter.languages")
  if not ok then
    return
  end

  for name, cfg in pairs(languages or {}) do
    fn(name, cfg)
  end
end

---Extract "special" plugin specs from language config files.
---@return LazyPluginSpec[]
function M.extract_plugin_specs()
  local function promote_plugin(cfg, plugin, fn)
    local value = cfg.plugins[plugin]
    if not value then
      return
    end

    table.insert(cfg.plugins, fn(value))
    cfg.plugins[plugin] = nil
  end

  local function promote_known_plugins(cfg)
    local L = require("peter.util.plugins.languages")

    for name, fn in pairs(L) do
      promote_plugin(cfg, name, fn)
    end
  end

  local LANG_MOD = require("peter.languages")

  return vim
    .iter(LANG_MOD)
    :map(function(name, cfg)
      promote_known_plugins(cfg)
      return name, cfg
    end)
    :fold({}, function(acc, _, cfg)
      vim.list_extend(acc, cfg.plugins or {})
      return acc
    end)
end

return M
