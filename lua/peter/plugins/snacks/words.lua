---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.words.Config
local Config = {
  enabled = true,
}

return {
  {
    "folke/snacks.nvim",

    ---@param opts snacks.Config
    opts = function(_, opts)
      opts.words = Config
    end,

    keys = function(_, keys)
      vim.list_extend(keys, {
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
      })
    end,
  },
}
