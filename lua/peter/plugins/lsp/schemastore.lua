---@module "lazy"

-- Schemas for 'jsonls' and 'yamlls'.
-- See 'https://github.com/b0o/SchemaStore.nvim'.
-- See 'https://www.schemastore.org'.
-- See 'https://github.com/microsoft/vscode-json-languageservice'.
-- See 'https://github.com/redhat-developer/yaml-language-server'.

-- See 'https://github.com/b0o/SchemaStore.nvim/issues/45' for how to use with
-- `vim.lsp.config`.

---@type LazyPluginSpec[]
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },
}
