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
      columns = { "icon", "type", "permissions", "size", "mtime" },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<localleader>|"] = { "actions.select", opts = { vertical = true } },
        ["<localleader>-"] = { "actions.select", opts = { horizontal = true } },
        ["<localleader>r"] = { "actions.refresh" },
      },
    },
  },
}
