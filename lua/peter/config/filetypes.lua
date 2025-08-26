vim.filetype.add({
  extension = {
    ["code-snippets"] = "json",
  },

  filename = {},

  pattern = {
    [".*/.github/workflows/.*%.ya?ml"] = "yaml.github",
    ["~/.ssh/config.d/.*"] = "sshconfig",
  },
})
