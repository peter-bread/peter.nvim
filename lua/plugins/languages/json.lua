local L = require("util.new_lang")

return {
  L.treesitter({
    "json",
    "json5",
  }),

  L.mason({
    "jsonls", -- lsp
    "prettier", -- formatter
  }),

  L.lspconfig({
    servers = {
      jsonls = {
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = {
              enable = true,
            },
          },
        },
        on_new_config = function(new_config, new_root_dir)
          new_config.settings.json.schemas = vim.tbl_deep_extend(
            "force",
            new_config.settings.json.schemas or {},
            require("schemastore").json.schemas()
          )
        end,
      },
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      json = { "prettier" },
    },
  }),
}
