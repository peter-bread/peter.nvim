local L = require("util.new_lang")

return {
  L.treesitter({
    "haskell",
  }),

  L.mason({
    "hls",
    -- "haskell-debug-adapter",
  }),

  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", -- Recommended
  },
}
