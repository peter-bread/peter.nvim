-- See 'https://rust-lang.org/'.

-- Assumes rust-analyzer and rustfmt are installed via rustup.
-- TODO: Add links or snippets to this.

---@type peter.lang.Config
return {
  lsp = { "rust_analyzer" },

  plugins = {
    format = { rust = { lsp_format = "prefer" } },
  },
}
