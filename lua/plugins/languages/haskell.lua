local L = require("util.new_lang")

return {
  L.treesitter({
    "haskell",
  }),

  L.mason({
    "hls",
    -- "haskell-debug-adapter",
  }),

  L.lspconfig({
    setup = {
      -- we want to let `haskell-tools` handle lsp setup
      hls = function()
        return true
      end,
    },
  }),

  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", -- Recommended
    -- lazy = false, -- This plugin is already lazy,
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
}
