return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      integrations = {
        ["mason-null-ls"] = false,
      },
      run_on_start = false,
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
      vim.cmd([[MasonToolsInstall]])
    end,
  },
}
