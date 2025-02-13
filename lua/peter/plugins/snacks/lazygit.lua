---@diagnostic disable: missing-fields

-- only include this part of the spec if
-- lazygit executable is found in PATH
if not vim.fn.exepath("lazygit") then
  return {}
end

---@module "snacks"

---@type snacks.lazygit.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      lazygit = Config,
    },
    keys = {
      {
        "<leader>gg",
        function()
          -- only open lazygit if in a git repo
          local root = vim.fs.root(0, ".git")
          if root then
            require("snacks").lazygit()
          end
        end,
        desc = "Lazygit",
      },
    },
  },
}
