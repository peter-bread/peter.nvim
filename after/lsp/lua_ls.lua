-- lua-language-server
-- https://luals.github.io/wiki/settings

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      codeLens = {
        enable = true,
      },
      completion = {
        autoRequire = false,
        callSnippet = "Replace", -- or "Both"
      },
      doc = {
        privateName = { "^_" },
      },
      -- stylua: ignore
      hint = {
        enable      = true,
        arrayIndex  = "Disable",  -- Show indices in arrays.
        paramName   = "Disable",  -- Show parameter names in function calls.
        paramType   = true,       -- Show parameter types at a function definition.
        semicolon   = "Disable",  -- Show semicolon at end of a statement.
        setType     = false,      -- Show inferred types at assignment.
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
