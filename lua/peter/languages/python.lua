---@module "conform"

local L = require("peter.util.plugins.languages")

-- Keep an eye on other Python LSPs. There is every chance these will become better
-- than 'basedpyright' in the future.
-- See 'https://github.com/astral-sh/ty'.
-- See 'https://github.com/facebook/pyrefly'.

---@type peter.lang.config
return {
  lsp = { "basedpyright", "ruff" },

  plugins = {
    L.treesitter({
      "python",
      -- "pymanifest"
    }),

    L.mason({
      "basedpyright",
      "ruff",
    }),

    L.format({
      python = { "ruff_organize_imports", "ruff_format" },
      -- We *could* use the following:
      -- python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      -- However, I think it's better to make actual code changes manually
      -- with intent, e.g. with an LSP Code Action (see `:h vim.lsp.buf.code_action`),
      -- rather than with a formatter that runs on every write.
    }),
  },
}
