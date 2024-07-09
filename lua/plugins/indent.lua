return {

  -- indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = false,
      },
    },
  },

  -- scope
  {
    "echasnovski/mini.indentscope",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(), -- *1
        },
        symbol = "│",
        options = {
          try_as_border = true,
        },
      })
    end,
  },
}

-- *1 Since the module is required during its own setup, it must be done in
--    the config function as it runs when the plugin is loaded.
--
--    (If it were in an external `opts` table, it would attempt to execute
--    before the plugin had been loaded so the module would not yet exist).
