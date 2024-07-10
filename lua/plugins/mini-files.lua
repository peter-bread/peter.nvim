return {
  "echasnovski/mini.files",
  version = false,
  opts = {
    windows = {
      preview = true,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Explore files (cwd)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Explore files (buf)",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}
