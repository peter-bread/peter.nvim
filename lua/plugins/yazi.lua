return {
  "mikavilpas/yazi.nvim",
  lazy = true,
  keys = {
    {
      "<leader>y",
      function()
        require("yazi").yazi()
      end,
      desc = "yazi",
    },
    {
      "<leader>Y",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "yazi (cwd)",
    },
  },
  ---@type YaziConfig
  opts = {
    open_for_directories = true,
  },
  config = function(_, opts)
    require("yazi").setup(opts)
  end,
}
