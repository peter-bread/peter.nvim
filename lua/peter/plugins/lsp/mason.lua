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
      opts.ensure_installed = require("peter.util.lists").remove_duplicates(
        opts.ensure_installed or {}
      )

      require("mason-tool-installer").setup(opts)

      -- install synchronously if in headless mode
      -- install async if running with UI
      if #vim.api.nvim_list_uis() == 0 then
        vim.cmd([[MasonToolsInstallSync]])
      else
        vim.cmd([[MasonToolsInstall]])
      end
    end,
  },
}
