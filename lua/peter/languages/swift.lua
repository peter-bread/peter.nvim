-- See 'https://www.swift.org/'.

---@type peter.lang.Config
return {
  lsp = { "sourcekit" },
  plugins = {
    format = { swift = { "swift_format" } },
  },
}
