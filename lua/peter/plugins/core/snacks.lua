---@module "lazy"
---@module "snacks"

-- Collection of QoL plugins.
-- See 'https://github.com/folke/snacks.nvim'.
--
-- Each plugin is configured in its own file.
-- These can be found in `lua/peter/plugins/snacks/<plugin>.lua`.

---@type LazyPluginSpec[]
return {
  {
    "folke/snacks.nvim",
    priority = 950,
    lazy = false,

    ---@type snacks.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {},
    keys = {},

    dependencies = { "mini.icons" },

    init = function()
      vim.api.nvim_create_autocmd("User", {
        group = require("peter.util.autocmds").augroup("SnacksInit"),
        pattern = "VeryLazy",
        callback = function()
          local toggle = require("snacks").toggle

          toggle.diagnostics():map("<leader>ud")
          toggle.inlay_hints():map("<leader>uh")
          toggle.indent():map("<leader>ui")

          require("peter.util.lazy").on_load("which-key.nvim", function()
            require("which-key").add({
              mode = { "n" },
              { "<leader>u", group = "ui" },
            })
          end)
        end,
      })
    end,
  },
}
