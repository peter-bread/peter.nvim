---@class Paths
---@field config string Neovim config directory
---@field plugins string Neovim plugin directory
---@field languages string Neovim languages directory

---@class Paths
local M = {}

local files = require("peter.util.files")

---@diagnostic disable-next-line: assign-type-mismatch
M.config = vim.fn.stdpath("config")

M.plugins = M.config .. "/lua/peter/plugins"

M.languages = M.plugins .. "/languages"

-- TODO: add documentation

---Paths to sensitive information
M.sensitive = {
  ssh = {
    match = { vim.fn.getenv("HOME") .. "/.ssh/" },
    exclude = { "%.pub$" },
  },
  gh_cli = {
    match = {
      files.safe_concat_path({
        files.first_non_nil_path({
          { vim.fn.getenv("GH_CONFIG_DIR") },
          { vim.fn.getenv("XDG_CONFIG_HOME"), "gh" },
          { vim.fn.getenv("HOME"), ".config/gh" },
        }),
        "hosts.yml",
      }) .. "$",
    },
    exclude = {},
  },

  -- TODO: work out how to define .env files
  env = {
    match = { "%.env(%..+)?$" },
    exclude = {},
  },
}

return M
