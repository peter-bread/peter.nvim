return {
  "echasnovski/mini.icons",
  lazy = true,
  -- no event required. will be loaded when another plugin needs it
  opts = {
    style = "glyph",
    --fallbacks for any other category
    default = {},
    -- directory path (basename only)
    directory = {
      ["config"] = { glyph = "" },
      ["plugin"] = { glyph = "" },
      ["plugins"] = { glyph = "" },
      ["workflows"] = { glyph = "󰄴" },
    },
    -- extensions w/o dot prefix
    extension = {},
    -- file path (basename only)
    file = {},
    -- filetype
    filetype = {
      lua = { hl = "MiniIconsBlue" },
    },
    -- "LSP kind" values
    lsp = {},
    -- operating system
    os = {},
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  config = function(_, opts)
    require("mini.icons").setup(opts)

    -- local icons = require("mini.icons")
    -- local get_icon_tbl = function(category, name)
    --   local icon, hl = icons.get(category, name)
    --   return { glyph = icon, hl = hl }
    -- end
    -- local dockerfile_icon_tbl = get_icon_tbl("filetype", "dockerfile")
    -- icons.setup({
    --   file = {
    --     ["docker-compose.yml"] = dockerfile_icon_tbl,
    --   },
    -- })
  end,
}
