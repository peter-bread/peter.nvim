-- Rust Analyzer
-- https://rust-analyzer.github.io/book/index.html
-- https://rust-analyzer.github.io/book/configuration.html

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.rust_analyzer
  settings = {
    ["rust-analyzer"] = {
      lens = { location = "above_whole_item" },
    },
  },
}
