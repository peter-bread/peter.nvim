---@diagnostic disable: unused-local

-- See 'https://www.haskell.org/'.

---@type peter.lang.config
return {
  plugins = {
    treesitter = { "haskell" },

    format = { haskell = { lsp_format = "prefer" } },

    mason = {
      -- Only install HLS with 'mason.nvim' if it is not already installed
      -- with GHCup.
      {
        "hls",
        condition = function()
          return vim.fn.executable("haskell-language-server-wrapper") == 0
        end,
      },
    },

    -- See 'https://github.com/mrcjkb/haskell-tools.nvim'.
    -- This plugin should be configured by modifying `vim.g.haskell-tools`.
    -- Furthermore, you can use 'after/ftplugin/haskell.lua', or
    -- `peter.lang.config.ftplugin` (in this file) to set buffer specific
    -- options or keymaps.
    {
      "mrcjkb/haskell-tools.nvim",
      version = "^6",
      lazy = false,
      init = function()
        vim.g.haskell_tools = {
          ---@type haskell-tools.tools.Opts
          tools = {
            -- ...
          },

          ---@type haskell-tools.lsp.ClientOpts
          ---You can also configure these via `:h vim.lsp.config`,
          ---with the "haskell-tools" key.
          hls = {
            ---@param client number The LSP client ID.
            ---@param bufnr number The buffer number
            ---@param ht HaskellTools = require('haskell-tools')
            on_attach = function(client, bufnr, ht)
              -- Set keybindings, etc. here.
            end,
          },
          ---@type haskell-tools.dap.Opts
          dap = {
            -- ...
          },
        }
      end,
    },
  },
}
