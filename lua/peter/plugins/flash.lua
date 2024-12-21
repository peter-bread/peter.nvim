---@diagnostic disable: missing-fields

return {
  {
    "folke/flash.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    ---@type Flash.Config
    opts = {
      label = {
        rainbow = {
          enabled = true,
        },
      },
      modes = {
        search = {
          enabled = true, -- enable in search by default
        },
      },
    },
    -- stylua: ignore start
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    -- stylua: ignore end
  },
}