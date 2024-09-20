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
  {
    name = "Use Make (no args, root level)",
    type = "codelldb",
    request = "launch",
    program = function()
      local root = vim.fs.root(0, "Makefile")
      if root then
        local cwd = vim.fn.getcwd()
        vim.cmd.lcd(root)
        vim.fn.system("make")
        vim.cmd.lcd(cwd)
        return vim.fn.input("Path to executable: ", root .. "/", "file")
      else
        return nil
      end
    end,
  },
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
        local ok, clangd_extensions = pcall(require, "clangd_extensions")
        if not ok then
          return
        end
        clangd_extensions.setup({
          inlay_hints = {
            inline = false,
          },
        })
      end,
    },
  }),

  L.dap({
    adapters = {
      codelldb = function()
        return {
          type = "server",
          host = "127.0.0.1",
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
