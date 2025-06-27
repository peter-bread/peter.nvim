-- https://luals.github.io/wiki/settings

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace", -- or "Both"
      },
      doc = {
        privateName = { "^_" },
      },
      -- stylua: ignore
      hint = {
        enable      = true,
        arrayIndex  = "Disable",  -- show indices in arrays
        paramName   = "Disable",  -- show parameter names in function calls
        paramType   = true,       -- show parameter types at a function definition
        semicolon   = "Disable",  -- show semicolon at end of a statement
        setType     = false,      -- show inferred types at assignment
      },
      hover = {
        previewFields = 1000,
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
