-- Ruff LSP.
-- See 'https://docs.astral.sh/ruff/editors/settings'.
-- See 'https://docs.astral.sh/ruff/editors/setup/#neovim'.

---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    -- Disable LSP Hover (see `:h vim.lsp.buf.hover`).
    -- Defer to '(based)pyright' for this.
    client.server_capabilities.hoverProvider = false
  end,
}
