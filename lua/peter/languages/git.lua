-- See 'https://git-scm.com/'.

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  plugins = {
    L.treesitter({
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "gitattributes",
    }),
  },
}
