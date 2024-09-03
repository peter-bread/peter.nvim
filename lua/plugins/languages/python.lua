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

  L.dap({
    deps = "mfussenegger/nvim-dap-python",
    setup = function()
      local path = vim.fn.getcwd() .. "/.venv/bin/python"
      require("dap-python").setup(path)
      -- add additional configurations here
      vim.list_extend(require("dap").configurations.python, {
        {
          type = "python",
          request = "launch",
          name = "PLEASE",
          program = "${file}",
          console = "integratedTerminal",
          env = {
            PYTHONPATH = "${workspaceFolder}:${workspaceFolder}/src",
          },
        },
      })
    end,
  }),

  -- L.dap({
  --   adapters = {
  --     python = function()
  --       local path = vim.fn.getcwd() .. "/.venv/bin/python"
  --       return function(callback, config)
  --         if config.request == "attach" then
  --           ---@diagnostic disable-next-line: undefined-field
  --           local port = (config.connect or config).port
  --           ---@diagnostic disable-next-line: undefined-field
  --           local host = (config.connect or config).host or "127.0.0.1"
  --           callback({
  --             type = "server",
  --             port = assert(
  --               port,
  --               "`connect.port` is required for a python `attach` configuration"
  --             ),
  --             host = host,
  --             options = {
  --               source_filetype = "python",
  --             },
  --           })
  --         else
  --           callback({
  --             type = "executable",
  --             command = path,
  --             args = { "-m", "debugpy.adapter" },
  --             options = {
  --               source_filetype = "python",
  --             },
  --           })
  --         end
  --       end
  --     end,
  --   },
  --   configurations = {
  --     python = {
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Launch File",
  --
  --         program = "${file}",
  --       },
  --     },
  --   },
  -- }),

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
