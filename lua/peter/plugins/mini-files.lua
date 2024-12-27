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

      local border = "MiniFilesBorder"
      local modified = "MiniFilesBorderModified"

      local border_hl = vim.api.nvim_get_hl(0, { name = border })
      local border_hl_link = vim.api.nvim_get_hl(0, { name = border_hl.link })

      local modified_hl = vim.api.nvim_get_hl(0, { name = modified })
      local modified_hl_link =
        vim.api.nvim_get_hl(0, { name = modified_hl.link })

      vim.api.nvim_set_hl(
        0,
        border,
        { fg = border_hl_link.bg, bg = border_hl_link.bg }
      )

      vim.api.nvim_set_hl(
        0,
        modified,
        { fg = modified_hl_link.fg, bg = border_hl_link.bg }
      )

      -- For other window customisation,
      -- See :h MiniFiles.examples  # Customize windows
    end,
  },
}
