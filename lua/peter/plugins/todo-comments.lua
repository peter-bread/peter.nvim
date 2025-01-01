return {
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
        mode = "n",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Prev todo comment",
        mode = "n",
      },
      {
        "<leader>ft",
        "<cmd>TodoTelescope<cr>",
        desc = "Todos",
        mode = "n",
      },
    },
    opts = {},
  },
}
