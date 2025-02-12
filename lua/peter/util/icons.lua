local M = {}

M.diagnostics = {
  fill = {
    Error = " ",
    Warn = " ",
    Hint = "󰌵 ",
    Info = "󰋼 ",
  },
  line = {
    Error = " ",
    Warn = " ",
    Hint = "󰌶 ",
    Info = " ",
  },
  -- other = {
  --   Error = " ",
  --   Warn = " ",
  --   Hint = " ",
  --   Info = " ",
  -- },
}

M.git = {
  -- nf-oct-diff-
  added = " ",
  removed = " ",
  modified = " ",
}

return M
