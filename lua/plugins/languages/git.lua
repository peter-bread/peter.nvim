local L = require("util.new_lang")

vim.filetype.add({
  pattern = {
    ["${DOTFILES}/git/.*gitconfig.*"] = "gitconfig",
    ["${DOTFILES}/git/.*gitignore.*"] = "gitignore",
  },
})

return {
  L.treesitter({
    "git_config",
    "gitcommit",
    "git_rebase",
    "gitignore",
    "gitattributes",
  }),
}
