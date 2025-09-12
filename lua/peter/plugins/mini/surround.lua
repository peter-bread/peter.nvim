---@module "lazy"
---@module "which-key"

-- Surround actions.
-- See 'https://github.com/nvim-mini/mini.surround'.

-- stylua: ignore
local mappings = {
  add             = "gsa",  -- Add surrounding.
  delete          = "gsd",  -- Delete surrounding.
  find            = "gsf",  -- Find surrounding (to the right).
  find_left       = "gsF",  -- Find surrounding (to the left).
  highlight       = "gsh",  -- Highlight surrounding.
  replace         = "gsr",  -- Replace surrounding.
}

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = mappings,
    },
    -- stylua: ignore
    keys = {
      { mappings.add,             desc = "Add Surrounding", mode = { "n", "v" } },
      { mappings.delete,          desc = "Delete Surrounding" },
      { mappings.find,            desc = "Find Right Surrounding" },
      { mappings.find_left,       desc = "Find Left Surrounding" },
      { mappings.highlight,       desc = "Highlight Surrounding" },
      { mappings.replace,         desc = "Replace Surrounding Surrounding" },
    },
  },
  P.which_key({
    mode = { "n", "v" },
    { "gs", group = "surround" },
  }),
}
