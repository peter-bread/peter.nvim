return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "]]",
      function()
        require("illuminate").goto_next_reference(true)
      end,
      mode = "n",
      desc = "Next Reference",
    },
    {
      "[[",
      function()
        require("illuminate").goto_prev_reference(true)
      end,
      mode = "n",
      desc = "Next Reference",
    },
  },
  opts = {},
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function setHighlightStyle()
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end

    -- change the highlight style
    setHighlightStyle()

    -- auto update the highlight style on colorscheme change
    vim.api.nvim_create_autocmd({ "Colorscheme" }, {
      pattern = { "*" },
      ---@diagnostic disable-next-line: unused-local
      callback = function(ev)
        setHighlightStyle()
      end,
    })
  end,
}
