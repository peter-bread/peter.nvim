---@module "lazy"
---@module "which-key"

-- surround actions
-- https://github.com/echasnovski/mini.surround

-- stylua: ignore
local mappings = {
  add             = "gsa", -- add surrounding
  delete          = "gsd", -- delete surrounding
  find            = "gsf", -- find surrounding (to the right)
  find_left       = "gsF", -- find surrounding (to the left)
  highlight       = "gsh", -- highlight surrounding
  replace         = "gsr", -- replace surrounding
  update_n_lines  = "gsn", -- update `n_lines`
}

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
  {
    "folke/which-key.nvim",
    ---@type wk.Opts
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "gs", group = "surround" },
        },
      },
    },
  },
}
