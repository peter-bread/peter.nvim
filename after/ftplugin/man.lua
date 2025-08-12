local keymap = require("peter.util.keymap")

-- By default, 'number' and 'relativenumber' are disabled and there are no
-- diagnostics. Therefore there is no need for 'statuscolumn'.
vim.wo.statuscolumn = ""

keymap.safe_del("n", "gO", { buffer = true })

vim.keymap.set("n", "gO", require("man").show_toc, {
  desc = "Table of Contents",
  buffer = true,
})
