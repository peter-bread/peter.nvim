return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  version = false,
  opts = {},
  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
}
