-- JSON Language Server.
-- See 'https://github.com/microsoft/vscode-json-languageservice'.

---@type vim.lsp.Config
return {

  settings = {
    json = {
      validate = { enable = true },
    },
  },

  before_init = function(_, config)
    local ok, schemastore = pcall(require, "schemastore")

    if ok then
      config.settings.json = vim.tbl_deep_extend(
        "force",
        {},
        config.settings.json,
        { schemas = schemastore.json.schemas() }
      )
    end
  end,
}
