local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "gopls" },

  plugins = {
    L.treesitter({ "go", "gomod", "gosum", "gowork", "gotmpl" }),
    L.mason({ "gopls", "gofumpt", "goimports" }),
    L.format({ go = { "goimports", "gofumpt" } }),
  },
}
