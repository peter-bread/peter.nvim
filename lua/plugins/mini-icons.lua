return {
  "echasnovski/mini.icons",
  lazy = true,
  -- no event required. will be loaded when another plugin needs it
  opts = {
    filetype = {
      gleam = { glyph = "󰓎" },
      lua = { hl = "MiniIconsBlue" },
    },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  config = function(_, opts)
    require("mini.icons").setup(opts)
  end,
}
