---@module "lazy"

-- Shared libraries that might be dependencies of many other plugins.
-- See 'https://github.com/nvim-lua/plenary.nvim'.

---@type LazyPluginSpec[]
return {
  { "nvim-lua/plenary.nvim", lazy = true },
}
