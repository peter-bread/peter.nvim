local keymap = require("peter.util.keymap")

-- 'number' and 'relativenumber' are both disabled by default so no need for
-- statuscolum.
vim.wo.statuscolumn = ""

keymap.safe_del("n", "gO", { buffer = true })

vim.keymap.set("n", "gO", require("man").show_toc, {
  desc = "Table of Contents",
  buffer = true,
})
