return {
  "nvim-lualine/lualine.nvim",
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
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard" } },
      },
      sections = {
        lualine_a = {
          -- vim mode
          { "mode" },
        },
        lualine_b = {
          -- git branch
          { "branch" },

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
        lualine_c = {
          -- diagnostics
          { "diagnostics" },

          -- relative filepath
          {
            "filename",
            path = 0,
          },
        },
        lualine_x = {
          -- no. of lazy package updates
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = {
          -- progress through file
          { "progress" },
        },
        lualine_z = {
          -- location in file
          { "location" },
        },
      },
      extensions = {
        "lazy",
        "man",
      },
    }
    return opts
  end,
}
