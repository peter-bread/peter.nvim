---@module "lazydev"

-- Better Lua Language Server setup for Neovim.
-- See 'https://github.com/folke/lazydev.nvim'.
-- See 'https://luals.github.io/wiki'.

-- LazyDev can be enabled/disabled in a project in multiple ways, in this order:
-- 1. Setting `vim.g.lazydev_enabled` in 'exrc'. See `:h 'exrc'`.
-- 2. TODO: Setting an environment variable.
-- 3. Creating a marker file; `.lazydev_{en|dis}abled`. If both exist, `_enabled`
--    will be prioritised.
-- 4. Checking if project root is in a list of known Neovim directories.

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    ---@type lazydev.Config
    opts = {
      library = {
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      enabled = function(root)
        if vim.g.lazydev_enabled ~= nil then
          return vim.g.lazydev_enabled
        end

        -- TODO: check an environment variable

        local enabled_file = root .. "/.lazydev_enabled"
        local disabled_file = root .. "/.lazydev_disabled"

        local has_enabled = vim.uv.fs_stat(enabled_file)
        local has_disabled = vim.uv.fs_stat(disabled_file)

        if has_enabled and has_disabled then
          vim.notify_once(
            "Both `.ladydev_enabled` and `.lazydev_disabled` found in: "
              .. root
              .. ".\nPrioritising `.lazydev_enabled`."
              .. "\nConsider removing one of these files.",
            vim.log.levels.WARN,
            { title = "LazyDev" }
          )
          return true
        end

        if has_enabled then
          return true
        end

        if has_disabled then
          return false
        end

        local paths = {
          vim.fn.stdpath("config"),
          vim.fn.stdpath("data") .. "/lazy",
          -- TODO: plugin development directory
        }

        for _, path in ipairs(paths) do
          if root:find(path, 1, true) == 1 then
            return true
          end
        end

        return false
      end,
    },
  },
  P.blink({
    default = { "lazydev" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  }),
}
