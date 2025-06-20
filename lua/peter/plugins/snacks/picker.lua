---@module "lazy"
---@module "snacks"
---@module "which-key"

---@type snacks.picker.Config
local cfg = {
  enabled = true,
  layout = {
    preset = "telescope",
  },
  layouts = {
    telescope = {
      layout = {
         -- TODO: solid borders
      },
    },
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

return {
  P.snacks({ picker = cfg }, {
    -- general
    { "<leader>S", function() require("snacks").picker() end, desc = "Search" },

    -- find
    { "<leader>ff", pick("files"), desc = "Files" },
    { "<leader>fF", pick("files", { hidden = true, ignored = true }), desc = "Files" },
    { "<leader>fr", pick("recent"), desc = "Recent" },

    -- search
    { "<leader>sg", pick("grep"), desc = "Grep" },
  }),

  P.which_key({
    mode = { "n" },
    { "<leader>f", group = "find" },
    { "<leader>s", group = "search" },
  }),
}
