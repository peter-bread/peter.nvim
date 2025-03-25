---@module "blink.cmp"
---@module "lazydev"

return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files

    ---@type lazydev.Config
    opts = {
      library = {
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
      integrations = {
        lspconfig = true,
        cmp = false,
        coq = false,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
