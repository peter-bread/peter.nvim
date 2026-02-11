local icons = require("peter.util.icons").diagnostics

vim.diagnostic.config({
  float = {
    source = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.INFO] = icons.Info,
      [vim.diagnostic.severity.HINT] = icons.Hint,
    },
  },
  virtual_text = {
    prefix = "●",
    source = false,
    spacing = 4,
  },
})
