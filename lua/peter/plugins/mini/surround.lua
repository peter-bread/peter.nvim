---@module "lazy"
---@module "which-key"

-- Surround actions.
-- See 'https://github.com/echasnovski/mini.surround'.

-- stylua: ignore
local mappings = {
  add             = "gsa",  -- Add surrounding.
  delete          = "gsd",  -- Delete surrounding.
  find            = "gsf",  -- Find surrounding (to the right).
  find_left       = "gsF",  -- Find surrounding (to the left).
  highlight       = "gsh",  -- Highlight surrounding.
  replace         = "gsr",  -- Replace surrounding.
  update_n_lines  = "gsn",  -- Update `n_lines`.
}

local P = require("peter.util.plugins.plugins")

---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.surround",
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
      { mappings.update_n_lines,  desc = "Delete Surrounding" },
    },
  },
  P.which_key({
    mode = { "n", "v" },
    { "gs", group = "surround" },
  }),
}
