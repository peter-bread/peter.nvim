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
  keys = function()
    local builtin = require("telescope.builtin")
    local colorscheme = function()
      builtin.colorscheme({ enable_preview = true })
    end
    return {
      { "<leader>ff", builtin.find_files, mode = "n", desc = "Find Files" },
      { "<leader>fg", builtin.live_grep, mode = "n", desc = "Live Grep" },
      { "<leader>fr", builtin.oldfiles, mode = "n", desc = "Recent Files" },
      { "<leader>fb", builtin.buffers, mode = "n", desc = "Find Buffers" },
      { "<leader>uc", colorscheme, mode = "n", desc = "Change Colorscheme" },
    }
  end,
  opts = {},
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension("fzf"))
  end,
}
