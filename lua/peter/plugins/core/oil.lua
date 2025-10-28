---@module "lazy"
---@module "oil"

-- File explorer.
-- See 'https://github.com/stevearc/oil.nvim'.

---@type LazyPluginSpec[]
return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    ---@type oil.SetupOpts
    opts = {
      columns = { "icon", "permissions", "size", "mtime" },
      skip_confirm_for_simple_edits = true,
      float = { border = "solid" },
      keymaps_help = { border = "solid" },
      confirmation = { border = "solid" },
      -- ssh = { border = "solid" },
      -- progress = { border = "solid" },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<localleader>|"] = { "actions.select", opts = { vertical = true } },
        ["<localleader>-"] = { "actions.select", opts = { horizontal = true } },
      },
    },
  },
}
