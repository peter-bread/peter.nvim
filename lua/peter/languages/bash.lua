---@module "conform"

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "bashls" },

  plugins = {
    L.treesitter({ "bash" }),

    -- stylua: ignore
    L.mason({
      "bashls",       -- LSP (uses shellcheck and shfmt if available)
      "shellcheck",   -- Linter
      "shfmt",        -- Formatter (main)
      "shellharden",  -- Formatter (corrects unsafe quoting)
    }),

    -- LSP will run `shfmt`, then we manually run `shellharden` after
    L.format({ sh = { lsp_format = "first", "shellharden" } }),
  },
}
