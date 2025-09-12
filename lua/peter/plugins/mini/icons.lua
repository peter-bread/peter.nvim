---@module "lazy"

-- Icon provider.
-- See 'https://github.com/nvim-mini/mini.icons'.

---@type LazyPluginSpec[]
return {
  {
    "nvim-mini/mini.icons",
    lazy = true,
    init = function()
      if vim.g.needs_nvim_web_devicons then
        require("mini.icons").mock_nvim_web_devicons()
      end
    end,
    opts = {
      style = vim.g.have_nerd_font and "glyph" or "ascii",

      -- stylua: igore start

      -- Fallbacks for any other category.
      default = {},

      -- Directory path (basename only).
      directory = {},

      -- Extensions without dot prefix.
      extension = {},

      -- Filename.
      file = {},

      -- Filetype.
      filetype = {},

      -- "LSP kind" values.
      lsp = {},

      -- Operating system.
      os = {},

      -- stylua: ignore end

      -- Control which extensions will be considered during "file" resolution.
      use_file_extensions = function(ext, file)
        return true
      end,
    },
  },
}
