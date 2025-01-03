return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    cmd = "Telescope",
    keys = {
    -- stylua: ignore start
    { "<leader>ff", "<cmd>Telescope find_files<cr>", mode = "n", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", mode = "n", desc = "Live Grep" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", mode = "n", desc = "Recent Files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", mode = "n", desc = "Find Buffers" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", mode = "n", desc = "Find LSP Symbols" },
    { "<leader>uC", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, mode = "n", desc = "Change Colorscheme" },
    { "<leader>fp", function() require("peter.util.telescope").project_files() end, mode = "n", desc = "Project Files" },
    { "<leader>fF", function() require("peter.util.telescope").find_all_files() end, mode = "n", desc = "Find All Files" },
    { "<leader>nf", function() require("peter.util.telescope").config.find_files.find_files() end, mode = "n", desc = "Config Files" },
    { "<leader>nl", function() require("peter.util.telescope").config.find_files.languages() end, mode = "n", desc = "Languages" },
    { "<leader>np", function() require("peter.util.telescope").config.find_files.plugins() end, mode = "n", desc = "Plugins" },
    { "<leader>nt", function() require("peter.util.telescope").config.find_files.temps() end, mode = "n", desc = "Temporary Files" },
    { "<leader>nF", function() require("peter.util.telescope").config.find_files.after_ftplugin() end, mode = "n", desc = "after/ftplugin" },
      -- stylua: ignore end
    },
    opts = {},
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension("fzf"))
    end,
  },
}
