local L = require("peter.util.new_lang")

return {
  L.treesitter({
    "java",
  }),

  L.mason({
    "jdtls",
    -- "java-debug-adapter",
    -- "java-test",
  }),

  L.lspconfig({
    servers = {
      jdtls = {},
    },
  }),
}
