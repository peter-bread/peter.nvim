local L = require("util.new_lang")

local dap_configurations = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  -- {
  --   name = "Use Make (no args)",
  --   type = "codelldb",
  --   request = "launch",
  --   program = function()
  --     -- TODO: check if makefile exists
  --     vim.fn.system("make")
  --     return vim.fn.getcwd() .. "/main"
  --   end,
  -- },
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    pid = function()
      require("dap.utils").pick_process()
    end,
    cwd = "${workspaceFolder}",
  },
}

return {
  L.treesitter({
    "c",
    "cpp",
  }),

  L.mason({
    "clangd", -- lsp
    "codelldb", -- dap
  }),

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
  },

  L.lspconfig({
    servers = {
      clangd = {},
    },
    setup = {
      clangd = function(server, opts)
        local ok, ce = pcall(require, "clangd_extensions")
        if not ok then
          return
        end
        ce.setup({
          inlay_hints = {
            inline = false,
          },
        })

        -- configure clangd_extensions when lsp attaches
        require("util.lsp").on_attach(function(client, bufnr)
          local inlay_hints = require("clangd_extensions.inlay_hints")
          inlay_hints.setup_autocmd()
          inlay_hints.set_inlay_hints()
        end, "clangd")
      end,
    },
  }),

  L.dap({
    adapters = {
      codelldb = function()
        return {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = vim.fn.exepath("codelldb"),
            args = { "--port", "${port}" },
          },
        }
      end,
    },
    configurations = {
      c = dap_configurations,
      cpp = dap_configurations,
    },
  }),
}
