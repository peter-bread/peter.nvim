-- Installing developer tools for Neovim.

-- TODO: evaluate mason-lspconfig.nvim and mason-tool-installer.nvim.
--
-- There is definitely an argument for just simplifying and rewriting some of
-- this logic here.
--
-- I only need mason-lspconfig.nvim for lspconfig mappings for mason-tool-installer.nvim,
-- but I can get these directly using mason.nvim.
--
-- EDIT: mason-lspconfig.nvim also provides auto generated filetype mappings.

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
        pattern = "mason",
        callback = function(ev)
          require("peter.util.lazy").on_load("which-key.nvim", function()
            require("which-key").add({
              mode = { "n" },
              { "g?", desc = "Toggle Mason Help", buffer = ev.buf },
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
  -- 1. in mason.nvim, provide lspconfig aliases (they appear in the mason UI
  --    using :Mason).
  -- 2. in mason-tool-installer.nvim, the lspconfig aliases are used so those
  --    names can be used when installing.
  -- As of https://github.com/mason-org/mason-registry/pull/9774,
  -- the lspconfig names are now built into the package specs themselves.
  -- Eventually, this plugin should be deprecated.
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
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

      -- install async when using UI (default)
      -- install synchronously when in headless mode (scripting)
      local is_headless = #vim.api.nvim_list_uis() == 0

      vim.schedule(function()
        require("mason-tool-installer").check_install(false, is_headless)
      end)
    end,
  },
}
