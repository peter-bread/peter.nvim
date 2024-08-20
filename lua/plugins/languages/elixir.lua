local L = require("util.new_lang")

return {
  L.treesitter({
    "elixir",
    "heex",
    "eex",
  }),

  L.mason({
    "elixirls",
  }),

  L.lspconfig({
    servers = {
      elixirls = {
        experimental = {
          completions = {
            enable = true,
          },
        },
      },
    },
  }),

  ---@module "neotest"

  L.test({
    dep = "jfpedroza/neotest-elixir",
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      adapters = {
        ["neotest-elixir"] = {},
      },
    },
  }),

  L.dap({
    adapters = {
      mix_task = function()
        return {
          type = "executable",
          command = vim.fn.exepath("elixir-ls-debugger"),
          args = {},
        }
      end,
    },
    configurations = {
      elixir = {
        {
          type = "mix_task",
          name = "mix task",
          task = "test",
          request = "launch",
          projectDir = "${workspaceFolder}",
        },
      },
    },
  }),
}
