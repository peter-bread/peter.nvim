local L = require("peter.util.new_lang")

return {
  L.treesitter2({
    "terraform",
    "hcl",
  }),

  L.mason2({
    "terraformls",
    "tflint",
  }),

  L.lspconfig({
    servers = {
      terraformls = {},
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
    },
  }),

  L.lint({
    linters_by_ft = {
      terraform = { "terraform_validate" },
      tf = { "terraform_validate" },
    },
  }),
}
