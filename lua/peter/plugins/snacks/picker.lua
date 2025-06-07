---@module "lazy"
---@module "snacks"
---@module "which-key"

---@type snacks.picker.Config
local cfg = {
  enabled = true,
  layout = {
    preset = "telescope",
  },
}

---Wrapper function to make config cleaner.
---@param source string Picker to use.
---@param opts? snacks.picker.Config Picker options.
---@return function
local function pick(source, opts)
  return function()
    require("snacks").picker.pick(source, opts)
  end
end

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "folke/snacks.nvim",
    optional = true,

    ---@type snacks.Config
    opts = {
      picker = cfg,
    },

    keys = {
      -- find
      { "<leader>ff", pick("files"), desc = "Files" },
      { "<leader>fr", pick("recent"), desc = "Recent" },
    },
  },
  P.which_key({
    mode = { "n" },
    { "<leader>f", group = "find" },
  }),
}
