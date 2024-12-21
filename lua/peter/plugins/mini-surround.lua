local mappings = {
  add = "gsa", -- Add surrounding in Normal and Visual modes
  delete = "gsd", -- Delete surrounding
  find = "gsf", -- Find surrounding (to the right)
  find_left = "gsF", -- Find surrounding (to the left)
  highlight = "gsh", -- Highlight surrounding
  replace = "gsr", -- Replace surrounding
  update_n_lines = "gsn", -- Update `n_lines`
}

return {
  {
    "echasnovski/mini.surround",
    keys = {
      { mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
      { mappings.delete, desc = "Delete Surrounding" },
      { mappings.find, desc = "Find Right Surrounding" },
      { mappings.find_left, desc = "Find Left Surrounding" },
      { mappings.highlight, desc = "Highlight Surrounding" },
      { mappings.replace, desc = "Replace Surrounding" },
      { mappings.update_n_lines, desc = "Update `config.n_lines`" },
    },
    opts = {
      mappings = mappings,
    },
  },
}
