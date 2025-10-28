---@module "conform"

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "sourcekit" },
  plugins = {
    L.format({ swift = { "swift_format" } }),
  },
}
