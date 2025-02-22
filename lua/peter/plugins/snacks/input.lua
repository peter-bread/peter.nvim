---@diagnostic disable: missing-fields

---@module "snacks"

---@type snacks.input.Config
local Config = {
  enabled = true,
  prompt_pos = "title",
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      input = Config,
      styles = {
        input = {
          relative = "cursor",
          row = -3,
          col = 0,
          width = 30,
          border = "solid",
          wo = {
            winhighlight = "NormalFloat:StatusLine",
          },
        },
      },
    },
  },
}
