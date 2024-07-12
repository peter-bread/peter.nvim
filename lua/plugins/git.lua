return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    cmd = "Gitsigns",
    opts = {
      -- stylua: ignore start
      signs = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signs_staged = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      -- stylua: ignore end
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 0,
        virt_text_pos = "right_align",
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- local gs = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { desc = "Next Hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { desc = "Prev Hunk" })

        map("n", "]H", function()
          gs.nav_hunk("last")
        end, { desc = "Last Hunk" })

        map("n", "[H", function()
          gs.nav_hunk("first")
        end, { desc = "First Hunk" })

        -- stylua: ignore start

        -- actions
        map({ "n", "v" }, "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
        map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
        map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>ghP", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        map("n", "<leader>ghP", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>ghB", function() gs.blame() end, { desc = "Blame Buffer" })
        map("n", "<leader>ght", gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
        map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff This ~" })

        -- text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", { desc = "Gitsigns Select Hunk" })

        -- stylua: ignore end
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
