-- See 'https://www.json.org/json-en.html'.

---@type peter.lang.Config
return {
  lsp = { "jsonls" },

  plugins = {
    treesitter = { "json", "json5" },
    mason = { "jsonls", "prettier" },
    format = {
      json = { "prettier" },
      -- Prettier will probably need to be configured for JSONC formatting on a per-project basis.
      -- See 'https://github.com/peter-bread/.dotfiles/commit/176620f25661c8a717fc5da676e6dbdaff43872b'
      -- for an example.
      jsonc = { "prettier" },
    },
  },
}
