---@module "lazy"
---@module "neogit"
---@module "diffview"

-- Interactive Git interface.
-- See 'https://github.com/NeogitOrg/neogit'.

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "NeogitOrg/neogit",
    dependencies = { "plenary.nvim", "diffview.nvim", "mini.icons" },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<C-x>g", "<cmd>Neogit<cr>", desc = "Neogit" }, -- Cheeky.
    },
    ---@type NeogitConfig
    opts = {},
  },
  P.which_key({
    mode = { "n" },
    { "<leader>g", group = "git" },
  }),
  {
    "sindrets/diffview.nvim",
    dependencies = {
      {
        -- TODO: Use GitHub version when public.
        dir = vim.fn.getenv("HOME")
          .. "/Developer/peter-bread/nvim-plugins/3rd-party.nvim",
        cond = function()
          return vim.fn.isdirectory(
            vim.fn.getenv("HOME")
              .. "/Developer/peter-bread/nvim-plugins/3rd-party.nvim"
          ) == 1
        end,
      },
    },
    lazy = true,
    ---@type DiffviewConfig
    opts = {
      view = {
        --[[
        Unless otherwise stated, the window symbols (A, B, C, D) represent
        the following versions of a file:

        In the diff_view and file_history_view:
          • A: Old state
          • B: New state

        In the merge_tool:
          • A: OURS (current branch)
          • B: LOCAL (the file as it currently exists on disk)
          • C: THEIRS (incoming branch)
          • D: BASE (common ancestor)

        {diff3_mixed}
            Available for: merge_tool

            ┌──────┬───────┐
            │  A   │   C   │
            │      │       │
            ├──────┴───────┤
            │      B       │
            │              │
            └──────────────┘

        {diff4_mixed}
            Available for: merge_tool

            ┌────┬────┬────┐
            │ A  │ D  │ C  │
            │    │    │    │
            ├────┴────┴────┤
            │      B       │
            │              │
            └──────────────┘

        See `:h diffview-config-view.x.layout`.
        ]]
        merge_tool = {
          -- Use 3-way diff by default.
          -- Use <M-l><M-l> to switch to 4-way diff, <M-l> to revert to 3-way diff.
          -- See keymaps below.
          layout = "diff3_mixed",
        },
      },
      keymaps = {
        view = {
          {
            { "n", "i" },
            "<M-l>",
            function()
              require("thirdparty.diffview").cycle_merge_conflict_layouts()
            end,
            { desc = "Toggle Merge layout" },
          },
        },
      },
    },
    config = function(_, opts)
      require("peter.util.icons").try_mock_nvim_web_devicons()
      require("diffview").setup(opts)
    end,
  },
}
