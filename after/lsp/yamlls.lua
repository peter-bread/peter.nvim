-- YAML Language Server.
-- See 'https://github.com/redhat-developer/yaml-language-server'.

---@type vim.lsp.Config
return {

  filetypes = {
    "yaml",
    "yaml.docker-compose",
    "yaml.gitlab",
    "yaml.helm-values",
    "yaml.github",
  },

  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },

  before_init = function(_, config)
    local ok, schemastore = pcall(require, "schemastore")

    if ok then
      config.settings.yaml = vim.tbl_deep_extend(
        "force",
        {},
        config.settings.yaml,
        { schemas = schemastore.yaml.schemas() }
      )
    end
  end,
}
