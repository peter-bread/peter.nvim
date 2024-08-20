local L = require("util.new_lang")

---@alias pyright_type "pyright"|"basedpyright"

---@type pyright_type
local pyright = "basedpyright"

return {
  L.treesitter({
    "python",
  }),

  L.mason({
    pyright, -- lsp
    "ruff", -- lsp/linter
  }),

  L.lspconfig({
    servers = {
      [pyright] = {},
      ruff = {},
    },
    setup = {
      ruff = function()
        require("util.lsp").on_attach(function(client, _)
          client.server_capabilities.hoverProvider = false
        end, "ruff")
      end,
    },
  }),

  ---@module "conform"

  L.format({
    formatters_by_ft = {
      python = { "ruff_organize_imports", "ruff_format" },
    },
  }),

  ---@module "neotest"

  L.test({
    dep = "nvim-neotest/neotest-python",
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  }),

  -- TODO: DAP

  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    cmd = "VenvSelect",
    ft = "python",
    keys = {
      {
        "<leader>cv",
        "<cmd>VenvSelect<cr>",
        desc = "Select VirtualEnv",
        ft = "python",
      },
    },
    opts = {},
  },
}
