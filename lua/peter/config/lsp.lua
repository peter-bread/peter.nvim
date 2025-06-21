local lsp = require("peter.util.lsp")
local languages = require("peter.util.languages")

-- enable LSPs
languages.for_each(function(_, cfg)
  if cfg.lsp then
    vim.lsp.enable(cfg.lsp)
  end
end)

lsp.delete_global_defaults()

lsp.on_attach(function(client, bufnr)
  lsp.set_default_keymaps(client, bufnr)

  if client:supports_method("textDocument/codeLens") then
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end

end)

do
  -- store active progress tokens for all running clients
  local active_tokens_by_client = {}

  -- refresh codelens whenever the LSP becomes idle
  vim.api.nvim_create_autocmd("LspProgress", {
    group = require("peter.util.autocmds").augroup("LspProgressCodeLens"),
    callback = function(ev)
      local client_id = ev.data.client_id
      local client = vim.lsp.get_client_by_id(client_id)

      if not client or not client:supports_method("textDocument/codeLens") then
        return
      end

      local value = ev.data.params.value
      local token = ev.data.params.token
      if not (value and token) then return end

      active_tokens_by_client[client_id] = active_tokens_by_client[client_id] or {}

      -- active tokens for the current client
      local active_tokens = active_tokens_by_client[client_id]

      if value.kind == "begin" then
        active_tokens[token] = true
      elseif value.kind == "end" then
        active_tokens[token] = nil

        -- check if all tokens are done
        for _, active in pairs(active_tokens) do
          if active then return end
        end

        -- no more progress, we're idle
        active_tokens_by_client[client_id] = nil
        vim.lsp.codelens.refresh()
      end
    end,
  })
end
