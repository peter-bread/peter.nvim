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
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(), -- 1*
        },
        symbol = "│",
      })
    end,
  },
}

-- 1* Since the module is required during its own setup, it must be done in
--    the config function as it runs when the plugin is loaded.
--
--    (If it were in an external `opts` table, it would attempt to execute
--    before the plugin had been loaded so the module would not yet exist).
