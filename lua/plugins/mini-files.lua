return {
  {
    "echasnovski/mini.files",
    dependencies = { "echasnovski/mini.icons" },
    version = false,
    opts = {
      windows = {
        preview = true,
        width_focus = 35,
        width_no_focus = 20,
        width_preview = 30,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Explore files (cwd)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Explore files (buf)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        group = vim.api.nvim_create_augroup("UserMiniFiles", { clear = true }),

        callback = function(args)
          local win_id = args.data.win_id

          -- Customise window-local settings
          vim.wo[win_id].winblend = 10

          local config = vim.api.nvim_win_get_config(win_id)
          config.border = "solid"

          vim.api.nvim_win_set_config(win_id, config)
        end,
      })
    end,
  },
}
