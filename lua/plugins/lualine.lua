return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
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
