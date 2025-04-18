return {
  {
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
          disabled_filetypes = { statusline = { "snacks_dashboard" } },
          component_separators = "",
          section_separators = "",
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
              symbols = require("peter.util.icons").git,
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
              path = 1,
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
            -- whether or not privacy mode is enabled
            {
              function()
                return "󰗹"
              end,
              cond = function()
                return vim.g.private_mode_enabled
              end,
            },
          },
          lualine_z = {
            -- location in file
            {
              "location",
              padding = 0,
            },

            -- filetype w/o icon
            {
              function()
                return vim.bo.filetype
              end,
            },
          },
        },
        extensions = {
          "lazy",
          "man",
        },
      }
      return opts
    end,
  },
}
