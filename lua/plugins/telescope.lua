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
    {
      "nvim-tree/nvim-web-devicons",
      enabled = vim.g.have_nerd_font,
    },
  },
  cmd = "Telescope",
  keys = function()
    local builtin = require("telescope.builtin")
    local colorscheme = function()
      builtin.colorscheme({ enable_preview = true })
    end
    return {
      { "<leader>ff", builtin.find_files, mode = "n", desc = "find files" },
      { "<leader>fg", builtin.live_grep, mode = "n", desc = "live grep" },
      { "<leader>fr", builtin.oldfiles, mode = "n", desc = "recent files" },
      { "<leader>fb", builtin.buffers, mode = "n", desc = "find buffers" },
      { "<leader>uc", colorscheme, mode = "n", desc = "change colorscheme" },
    }
  end,
  opts = {},
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension("fzf"))
  end,
}
