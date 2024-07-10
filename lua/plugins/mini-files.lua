return {
  "echasnovski/mini.files",
  version = false,
  opts = {
    windows = {
      preview = true,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>e", function() require("mini.files").open(vim.uv.cwd(), true) end },
    { "-", function() require("mini.files").open(vim.uv.cwd(), true) end },
    { "<leader>E", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}
