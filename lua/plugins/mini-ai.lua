return {
  "echasnovski/mini.ai",
  version = false,
  opts = {},
  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
}
