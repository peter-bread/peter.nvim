---@module "lazy"

-- icon provider
-- https://github.com/echasnovski/mini.icons

---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      if vim.g.needs_nvim_web_devicons then
        require("mini.icons").mock_nvim_web_devicons()
      end
    end,
    opts = {
      style = vim.g.have_nerd_font and "glyph" or "ascii",

      -- fallbacks for any other category
      -- stylua: ignore
      default = {},

      -- directory path (basename only)
      -- stylua: ignore
      directory = {},

      -- extensions w/o dot prefix
      -- stylua: ignore
      extension = {},

      -- filename
      -- stylua: ignore
      file = {},

      -- filetype
      -- stylua: ignore
      filetype = {},

      -- "LSP kind" values
      -- stylua: ignore
      lsp = {},

      -- operating system
      -- stylua: ignore
      os = {},

      -- control which extensions will be considered during "file" resolution
      use_file_extensions = function(ext, file)
        return true
      end,
    },
  },
}
