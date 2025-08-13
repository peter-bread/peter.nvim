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
    },
  },
}
