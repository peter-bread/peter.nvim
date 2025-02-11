---@class Paths
---@field config string Neovim config directory
---@field plugins string Neovim plugin directory
---@field languages string Neovim languages directory

---@class Paths
local M = {}

---@diagnostic disable-next-line: assign-type-mismatch
M.config = vim.fn.stdpath("config")

M.plugins = M.config .. "/lua/peter/plugins"

M.languages = M.plugins .. "/languages"

return M
