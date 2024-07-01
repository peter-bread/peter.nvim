return {
  "mikavilpas/yazi.nvim",
  lazy = true,
  keys = function()
    local yazi = require("yazi")
    return {
      { "<leader>y", yazi.yazi, desc = "yazi" },
      {
        "<leader>Y",
        function()
          yazi.yazi(nil, vim.fn.getcwd())
        end,
        desc = "yazi (cwd)",
      },
    }
  end,
  ---@type YaziConfig
  opts = {
    open_for_directories = true,
  },
  config = function(_, opts)
    require("yazi").setup(opts)
  end,
}
