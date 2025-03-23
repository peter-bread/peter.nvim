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
        pattern = "TogglePrivateMode",
        group = require("peter.util.autocmds").augroup("TogglePrivateMode"),
        callback = function(ev)
          MiniFiles.config.windows.preview = not ev.data
          MiniFiles.close()
          MiniFiles.refresh({})
        end,
      })
    end,
  },
}
