return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files

    ---@module "lazydev"
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

    ---@module "blink.cmp"

    ---Extend `opts` table
    ---@param _ any
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.sources.default =
        vim.list_extend({ "lazydev" }, opts.sources.default or {})

      opts.sources.providers =
        vim.tbl_extend("force", opts.sources.providers or {}, {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        })
    end,
  },
}
