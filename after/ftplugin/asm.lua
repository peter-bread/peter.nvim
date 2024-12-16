---@diagnostic disable-next-line: unused-local
require("util.lsp").on_attach(function(client, bufnr)
  local root = vim.fs.root(0, ".git")

  if not root then
    vim.notify("Couldn't find git root", vim.log.levels.WARN)
    return
  end

  local conf_files =
    vim.fs.find(".asm-lsp.toml", { type = "file", path = root })

  if #conf_files ~= 1 then
    vim.notify(
      "Suggestion: add .asm-lsp.toml in project root.",
      vim.log.levels.WARN
    )
  end
end, "asm_lsp")
