-- https://writewithharper.com/docs/integrations/neovim
-- https://writewithharper.com/docs/integrations/language-server#Configuration

local L = require("peter.util.new_lang")

local files = require("peter.util.files")

local userDictPath = files.safe_concat_path({
  vim.fn.getenv("XDG_DATA_HOME"),
  "harper-ls",
  "dictionary.txt",
})

local fileDictPath = files.safe_concat_path({
  vim.fn.getenv("XDG_DATA_HOME"),
  "harper-ls",
  "file_dictionaries",
})

return {
  L.mason({
    "harper_ls",
  }),

  L.lspconfig({
    servers = {
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            userDictPath = userDictPath,
            fileDictPath = fileDictPath,

            diagnosticSeverity = "hint",

            -- cut-and-paste config for fewer false positives when programming
            linters = {
              SentenceCapitalization = false,
              SpellCheck = false,
            },

            markdown = { IgnoreLinkTitle = true },
          },
        },
      },
    },
  }),
}
