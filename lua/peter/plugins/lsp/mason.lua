---@module "lazy"
---@module "mason"
---@module "mason-lspconfig"

-- Install developer tools (LSP, Formatter, Linter, DAP) for Neovim.
-- See 'https://github.com/mason-org/mason.nvim'.
-- See 'https://github.com/mason-org/mason-lspconfig.nvim'.
-- See 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim'.

-- TODO: Evaluate 'mason-lspconfig.nvim' and 'mason-tool-installer.nvim'.
--
-- There is definitely an argument for just simplifying and rewriting some of
-- this logic here.
--
-- I only need 'mason-lspconfig.nvim' for lspconfig mappings for
-- 'mason-tool-installer.nvim', but I can get these directly using 'mason.nvim'.
--
-- EDIT: 'mason-lspconfig.nvim' also provides auto generated filetype mappings.

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "mason-org/mason.nvim",
    lazy = true,
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    ---@type MasonSettings
    opts = {
      ui = {
        icons = {
          package_installed = "󰸞 ",
          package_pending = "󱥸 ",
          package_uninstalled = "󱎘 ",
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = require("peter.util.autocmds").augroup("MasonKeymapDesc"),
        pattern = "mason",
        callback = function(ev)
          require("peter.util.lazy").on_load("which-key.nvim", function()
            -- stylua: ignore
            require("which-key").add({
              mode = { "n" },
              { "g?", desc = "Mason Toggle Help", buffer = ev.buf },

              { "1",  desc = "Mason All", buffer = ev.buf },
              { "2",  desc = "Mason LSP", buffer = ev.buf },
              { "3",  desc = "Mason DAP", buffer = ev.buf },
              { "4",  desc = "Mason Linter", buffer = ev.buf },
              { "5",  desc = "Mason Formatter", buffer = ev.buf },

              { "i",  desc = "Mason Install Package", buffer = ev.buf },
              { "X",  desc = "Mason Uninstall Package", buffer = ev.buf },
              { "u",  desc = "Mason Update Package", buffer = ev.buf },
              { "U",  desc = "Mason Update All Outdated Package", buffer = ev.buf },
              { "c",  desc = "Mason Check for New Package Version", buffer = ev.buf },
              { "C",  desc = "Mason Check New Versions (All Packages)", buffer = ev.buf },

              { "<C-f>", desc = "Mason Apply Language Filter", buffer = ev.buf },
              { "<cr>", desc = "Mason Toggle Info", buffer = ev.buf },

              { "<esc>", desc = "Mason Close Window", buffer = ev.buf },
              { "q", desc = "Mason Close Window", buffer = ev.buf },
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

  -- This can hopefully be removed at some point.
  -- Currently, it is used for 2 things:
  -- 1. in 'mason.nvim', provide lspconfig aliases (they appear in the mason UI
  --    using :Mason).
  -- 2. in 'mason-tool-installer.nvim', the lspconfig aliases are used so those
  --    names can be used when installing.
  -- As of 'https://github.com/mason-org/mason-registry/pull/9774',
  -- the lspconfig names are now built into the package specs themselves.
  -- Eventually, this plugin should be deprecated.
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    ---@type MasonLspconfigSettings
    opts = { automatic_enable = false },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
    opts_extend = { "ensure_installed" },
    opts = {
      -- stylua: ignore
      integrations = {
        ["mason-lspconfig"] = true,
        ["mason-null-ls"]   = false,
        ["mason-nvim-dap"]  = false,
      },
      run_on_start = false,
    },
    config = function(_, opts)
      local list = require("peter.util.list")

      opts.ensure_installed = list.uniq(opts.ensure_installed or {})

      require("mason-tool-installer").setup(opts)

      -- Install async when using UI (default).
      -- Install synchronously when in headless mode (scripting).
      local is_headless = #vim.api.nvim_list_uis() == 0

      if is_headless then
        vim.api.nvim_create_autocmd("User", {
          pattern = "MasonToolsStartingInstall",
          callback = function()
            vim.schedule(function()
              print("mason-tool-installer is starting...\n")
            end)
            return true
          end,
        })

        vim.api.nvim_create_autocmd("User", {
          pattern = "MasonToolsUpdateCompleted",
          callback = function(e)
            vim.schedule(function()
              print("The following packages were installed:")
              print(vim.inspect(e.data) .. "\n")
            end)
            return true
          end,
        })
      end

      vim.schedule(function()
        require("mason-tool-installer").check_install(false, is_headless)
      end)
    end,
  },
}
