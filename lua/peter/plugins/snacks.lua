---Get config options for a snack.
---@param snack string Name of snack
---@return any
local get = function(snack)
  return require("peter.plugins.snacks." .. snack)
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
      dim = get("dim"),
      indent = get("indent"),
      lazygit = get("lazygit"),
      notifier = get("notifier"),
      scope = get("scope"),
      terminal = get("terminal"),
      toggle = get("toggle"),
      words = get("words"),
    },
    keys = {
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
    },
  },
}
