return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    -- no event required. will be loaded when another plugin needs it
    opts = {
      style = "glyph",

      --fallbacks for any other category
      default = {},

      -- directory path (basename only)
      directory = {
        -- stylua: ignore start
        ["config"]    = { glyph = "" },
        ["plugin"]    = { glyph = "" },
        ["plugins"]   = { glyph = "" },
        ["workflows"] = { glyph = "󰄴" },
        ["util"]      = { glyph = "󱧼" },
        ["utils"]     = { glyph = "󱧼" },
        -- stylua: ignore end
      },

      -- extensions w/o dot prefix
      extension = {},

      -- file path (basename only)
      file = {
        -- stylua: ignore start
        [".ignore"]                 = { glyph = "", hl = "MiniIconsRed" },
        [".gitignore"]              = { hl = "MiniIconsRed" },
        [".prettierignore"]         = { glyph = "", hl = "MiniIconsRed" },
        [".prettierrc"]             = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.json"]        = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.yml"]         = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.yaml"]        = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.json5"]       = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.js"]          = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.config.js"]   = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.mjs"]         = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.config.mjs"]  = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.cjs"]         = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.config.cjs"]  = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc.toml"]        = { glyph = "", hl = "MiniIconsGrey" },
        ["lazy-lock.json"]          = { glyph = "󰒲" },
        [".nvim.lua"]               = { glyph = "", hl = "MiniIconsGreen" },
        ["README.md"]               = { glyph = "󰋼", hl = "MiniIconsBlue" },
        -- stylua: ignore end
      },

      -- filetype
      filetype = {
        -- stylua: ignore start
        lua       = { hl = "MiniIconsBlue" },
        markdown  = { hl = "MiniIconsBlue" },
        -- stylua: ignore end
      },

      -- "LSP kind" values
      lsp = {},

      -- operating system
      os = {},

      -- default value right now
      use_file_extensions = function(ext, file)
        return true
      end,
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
  },
}
