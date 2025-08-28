-- gopls
-- See 'https://github.com/golang/tools/tree/master/gopls'.
-- See 'https://github.com/golang/tools/blob/master/gopls/doc/index.md'.
-- See 'https://github.com/golang/tools/blob/master/gopls/doc/settings.md'.

---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = {
        "-.git",
        "-.vscode",
        "-.idea",
        "-.vscode-test",
        "-node_modules",
      },
      semanticTokens = true,
    },
  },
  on_attach = function(client, _)
    -- Semantic Tokens workaround.
    -- See 'https://github.com/golang/go/issues/54531#issuecomment-1464982242'.

    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      if semantic then
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = {
            tokenModifiers = semantic.tokenModifiers,
            tokenTypes = semantic.tokenTypes,
          },
          range = true,
        }
      end
    end
  end,
}
