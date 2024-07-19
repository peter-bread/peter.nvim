return {
  "echasnovski/mini.icons",
  lazy = true,
  -- no event required. will be loaded when another plugin needs it
  opts = {
    style = "glyph",
    default = {}, -- fallbacks for any other category
    directory = { -- directory path (basename only)
      ["config"] = { glyph = "" },
      ["plugin"] = { glyph = "" },
      ["plugins"] = { glyph = "" },
      ["workflows"] = { glyph = "󰄴" },
    },
    extension = {}, -- extensions w/o dot prefix
    file = {}, -- file path (basename only)
    filetype = { -- filetype
      lua = { hl = "MiniIconsBlue" },
    },
    lsp = {}, -- "LSP kind" values
    os = {}, -- operating system
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
