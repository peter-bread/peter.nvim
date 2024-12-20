-- set custom filetypes here

vim.filetype.add({

  extension = {
    ["code-snippets"] = "json",
  },

  filename = {},

  pattern = {
    ["${DOTFILES}/git/.*gitconfig.*"] = "gitconfig",
    ["${DOTFILES}/git/.*gitignore.*"] = "gitignore",

    -- create filetypes so actionlint doesn't run on all yaml files
    [".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
    [".*/.github/workflows/.*%.yaml"] = "yaml.ghaction",
  },
})
