---@module "conform"

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "clangd" },
  plugins = {
    L.mason({ "clangd" }),
    L.format({ c = { lsp_format = "prefer" } }),
  },
}
