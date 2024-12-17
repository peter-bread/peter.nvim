return {
  {
    "alexghergh/nvim-tmux-navigation",
    cond = function()
      -- only load if in tmux session
      return vim.fn.getenv("TMUX") ~= vim.NIL
    end,
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    },
  },
}
