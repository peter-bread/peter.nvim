-- See 'https://www.gnu.org/software/bash/'.

---@type peter.lang.config
return {
  lsp = { "bashls" },

  plugins = {
    treesitter = { "bash" },

    -- stylua: ignore
    mason = {
      "bashls",       -- LSP (uses shellcheck and shfmt if available); node/npm.
      "shellcheck",   -- Linter.
      "shfmt",        -- Formatter (main).
      "shellharden",  -- Formatter (corrects unsafe quoting); cargo.
    },

    -- LSP will run `shfmt`, then we manually run `shellharden` after.
    format = { sh = { lsp_format = "first", "shellharden" } },
  },
}
