local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {

  plugins = {
    L.treesitter({ "ruby" }),
  },
}
