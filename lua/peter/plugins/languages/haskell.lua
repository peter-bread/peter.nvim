local L = require("peter.util.new_lang")

local ret = {
  L.treesitter2({
    "haskell",
  }),

  L.mason2({
    -- "haskell-debug-adapter",
  }),

  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", -- Recommended
  },
}

-- only install haskell language server if not already installed
-- (on my systems it should be installed through ghcup)
if vim.fn.exepath("haskell-language-server-wrapper") == "" then
  vim.list_extend(ret, L.mason2({ "hls" }))
end

return ret
