---@module "lazy"
---@module "thirdparty"
---@module "mason"

-- Install developer tools (LSP, Formatter, Linter, DAP) for Neovim.
-- See 'https://github.com/mason-org/mason.nvim'.
-- See 'https://github.com/mason-org/mason-lspconfig.nvim'.
-- See 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim'.

local P = require("peter.util.plugins.plugins")

---@class peter.mason.Opts : MasonSettings
---@field ensure_installed? thirdparty.MasonToolInstaller.PackageSpec[]

---@type LazyPluginSpec[]
return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "peter-bread/3rd-party.nvim",
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },

    ---@type peter.mason.Opts
    opts = {
      ui = {
        -- stylua: ignore
        icons = {
          package_installed   = "󰸞 ",
          package_pending     = "󱥸 ",
          package_uninstalled = "󱎘 ",
        },
      },
      ensure_installed = {},
    },

    ---@param opts peter.mason.Opts
    config = function(_, opts)
      local list = require("peter.util.list")
      opts.ensure_installed = list.uniq(opts.ensure_installed or {})

      require("mason").setup(opts --[[@as MasonSettings]])

      require("thirdparty.mason-lspconfig").register_lspconfig_aliases()

      local installer = require("thirdparty.mason-tool-installer")
      installer.setup(opts --[[@as thirdparty.MasonToolInstaller.Config]])

      -- Do not install packages if PETER_NVIM_NO_MASON_INSTALL=1.
      -- This is mainly for CI pipelines.
      if vim.env.PETER_NVIM_NO_MASON_INSTALL == "1" then
        vim.schedule(function()
          vim.print("Skipping mason package installation\n")
        end)
        return
      end

      installer.check_install(vim.g.is_headless)
    end,

    init = function()
      vim.api.nvim_create_user_command("MasonToolsClean", function()
        require("thirdparty.mason-tool-installer").clean()
      end, { force = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = require("peter.util.autocmds").augroup("MasonKeymapDesc"),
        pattern = "mason",
        callback = function(ev)
          require("peter.util.lazy").on_load("which-key.nvim", function()
            -- stylua: ignore
            require("which-key").add({
              mode = { "n" },
              { "g?",    desc = "Mason Toggle Help",                       buffer = ev.buf },

              { "1",     desc = "Mason All",                               buffer = ev.buf },
              { "2",     desc = "Mason LSP",                               buffer = ev.buf },
              { "3",     desc = "Mason DAP",                               buffer = ev.buf },
              { "4",     desc = "Mason Linter",                            buffer = ev.buf },
              { "5",     desc = "Mason Formatter",                         buffer = ev.buf },

              { "i",     desc = "Mason Install Package",                   buffer = ev.buf },
              { "X",     desc = "Mason Uninstall Package",                 buffer = ev.buf },
              { "u",     desc = "Mason Update Package",                    buffer = ev.buf },
              { "U",     desc = "Mason Update All Outdated Package",       buffer = ev.buf },
              { "c",     desc = "Mason Check for New Package Version",     buffer = ev.buf },
              { "C",     desc = "Mason Check New Versions (All Packages)", buffer = ev.buf },

              { "<C-f>", desc = "Mason Apply Language Filter",             buffer = ev.buf },
              { "<cr>",  desc = "Mason Toggle Info",                       buffer = ev.buf },

              { "<esc>", desc = "Mason Close Window",                      buffer = ev.buf },
              { "q",     desc = "Mason Close Window",                      buffer = ev.buf },
            })
          end)
        end,
      })
    end,
  },
  P.which_key({
    mode = { "n" },
    { "<leader>c", group = "code" },
  }),
}
