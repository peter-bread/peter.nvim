vim.filetype.add({
  extension = {
    ["code-snippets"] = "json",
  },

  filename = {},

  pattern = {
    [".*/.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
    ["~/.ssh/config.d/.*"] = "sshconfig",
  },
})
