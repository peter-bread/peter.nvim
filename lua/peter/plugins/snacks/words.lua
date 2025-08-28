---@module "lazy"
---@module "snacks"

-- Auto-show LSP references and quickly navigate between them.
-- See 'https://github.com/folke/snacks.nvim/blob/main/docs/words.md'.

local P = require("peter.util.plugins.plugins")

---@type snacks.words.Config
local cfg = {
  enabled = true,
}

---@type LazyPluginSpec[]
return {
  P.snacks({ words = cfg }, {
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
  }),
}
