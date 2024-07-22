return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x", -- release branch
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
    { "<leader>uc", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end },
    -- stylua: ignore end
  },
  opts = {},
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension("fzf"))
  end,
}
