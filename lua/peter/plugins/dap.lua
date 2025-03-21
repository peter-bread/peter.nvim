return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").restart() end, desc = "Restart"},
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    },
    config = function(_, opts)
      local dap = require("dap")
      require("mason-nvim-dap").setup()

      -- enable .vscode/launch.json configurations
      -- WARN: deprecated
      require("dap.ext.vscode").load_launchjs()

      -- setup user-created adapters
      for name, adapter in pairs(opts.adapters or {}) do
        dap.adapters[name] = adapter
      end

      -- setup user-created configurations
      for name, configurations in pairs(opts.configurations or {}) do
        dap.configurations[name] = configurations
      end

      -- setup language extensions
      for _, language_extension in ipairs(opts.language_extensions or {}) do
        if type(language_extension) == "function" then
          language_extension()
        end
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {},
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependencies = "mason.nvim",
  },
}
