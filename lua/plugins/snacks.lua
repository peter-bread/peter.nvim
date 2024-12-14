---Get config options for a snack.
---@param snack string Name of snack
---@return any
local get = function(snack)
  return require("plugins.snacks." .. snack)
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      dashboard = get("dashboard"),
      notifier = get("notifier"),
      indent = get("indent"),
      scope = get("scope"),
      words = get("words"),
    },
    keys = {
      {
        "]]",
        function()
          require("snacks").words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          require("snacks").words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
    },
  },
}
