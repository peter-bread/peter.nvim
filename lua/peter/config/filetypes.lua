vim.filetype.add({
  extension = {
    ["code-snippets"] = "json",
  },

  filename = {
    [".swift-format"] = "json",
  },

  pattern = {
    -- This is not needed any more.
    -- LSPs can use `root_dir` function.
    -- Linters can use `on_lint` function.
    -- I'll keep this here just in case I need it for some reason in the future.
    -- [".*/.github/workflows/.*%.ya?ml"] = "yaml.github",

    ["~/.ssh/config.d/.*"] = "sshconfig",
  },
})
