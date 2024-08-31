require("util.lsp").on_attach(function(client, bufnr)
  local root = require("lspconfig").util.find_git_ancestor(vim.fn.expand("%:p"))

  local conf_files =
    vim.fs.find(".asm-lsp.toml", { type = "file", path = root })

  if #conf_files ~= 1 then
    vim.notify(
      "Suggestion: add .asm-lsp.toml in project root.",
      vim.log.levels.WARN
    )
  end
end, "asm_lsp")
