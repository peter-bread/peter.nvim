local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "java",
  }),

  L.mason2({
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
