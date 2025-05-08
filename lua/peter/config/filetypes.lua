-- define custom filetypes

vim.filetype.add({
  extension = {
    ["code-snippets"] = "json",
  },

  filename = {},

  pattern = {
    ["~/.ssh/config.d/.*"] = "sshconfig",
  },
})
