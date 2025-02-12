---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.words.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      words = Config,
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
