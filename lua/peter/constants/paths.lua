local M = {}

M.config = vim.fn.stdpath("config")

M.plugins = M.config .. "/lua/peter/plugins"

M.languages = M.plugins .. "/languages"

return M
