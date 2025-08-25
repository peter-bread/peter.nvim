---@module "lazy"
---@module "neogit"

-- Interactive Git interface.
-- See 'https://github.com/NeogitOrg/neogit'.

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "NeogitOrg/neogit",
    dependencies = { "plenary.nvim" },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<C-x>g", "<cmd>Neogit<cr>", desc = "Neogit" }, -- Cheeky.
    },
    ---@type NeogitConfig
    opts = {},
  },
  P.which_key({
    mode = { "n" },
    { "<leader>g", group = "git" },
  }),
}
