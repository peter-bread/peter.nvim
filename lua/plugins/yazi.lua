return {
  "mikavilpas/yazi.nvim",
  lazy = true,
  cond = function() -- only install/load if yazi is installed on machine
    return vim.fn.executable("yazi") == 1
  end,
  keys = function()
    local yazi = require("yazi")
    return {
      { "<leader>y", yazi.yazi, desc = "Yazi" },
      {
        "<leader>Y",
        function()
          yazi.yazi(nil, vim.fn.getcwd())
        end,
        desc = "Yazi (cwd)",
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
