-- See 'https://git-scm.com/'.

---@type peter.lang.config
return {
  plugins = {
    treesitter = {
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "gitattributes",
    },
  },
}
