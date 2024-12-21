local L = require("peter.util.new_lang")

return {
  L.mason({
    "ansiblels",
    "ansible-lint",
  }),

  L.lspconfig({
    servers = {
      ansiblels = {},
    },
  }),
}
