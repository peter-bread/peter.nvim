---@module "lazy"

---@type LazyPluginSpec[]
return {
  {
    "stevearc/oil.nvim",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    opts = {
      columns = { "icon", "permissions", "size", "mtime" },
      skip_confirm_for_simple_edits = true,
    },
  },
}
