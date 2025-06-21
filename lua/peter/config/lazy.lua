-- lazy.nvim plugin manager

-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local languages = require("peter.util.languages")
local lang_plugins = {}

-- get language-specific plugins
languages.for_each(function(_, cfg)
  if cfg.plugins then
    vim.list_extend(lang_plugins, cfg.plugins)
  end
end)

-- setup and configure
require("lazy").setup({
  spec = {
    { import = "peter.plugins.core" },
    { import = "peter.plugins.mini" },
    { import = "peter.plugins.snacks" },
    { import = "peter.plugins.lsp" },
    { lang_plugins },
  },
  install = {
    colorscheme = { "kanagawa", "default" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "matchit",
        "matchparen",
        "tutor",
      },
    },
  },
})
