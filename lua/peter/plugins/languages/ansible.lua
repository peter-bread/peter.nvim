local L = require("peter.util.new_lang")

return {
  L.mason2({
    "ansiblels",
    "ansible-lint",
  }),

  L.lspconfig({
    servers = {
      ansiblels = {},
    },
  }),
}
