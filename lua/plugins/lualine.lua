return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_x = {

        -- no. of lazy package updates
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },

        -- git diff
        {
          "diff",
          symbols = {
            -- nf-oct-diff-
            added = " ",
            removed = " ",
            modified = " ",
          },
          source = function()
            local gs = vim.b.gitsigns_status_dict
            if gs then
              return {
                added = gs.added,
                removed = gs.removed,
                modified = gs.changed,
              }
            end
          end,
        },
      },
    },
  },
}
