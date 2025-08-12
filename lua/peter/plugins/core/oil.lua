---@module "lazy"
---@module "oil"

---@type LazyPluginSpec[]
return {
  {
    "stevearc/oil.nvim",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    ---@type oil.SetupOpts
    opts = {
      columns = { "icon", "permissions", "size", "mtime" },
      skip_confirm_for_simple_edits = true,
    },
  },
}
