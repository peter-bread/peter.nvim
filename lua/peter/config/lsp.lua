local lsp = require("peter.util.lsp")
local autocmds = require("peter.util.autocmds")

-- Enable LSPs *after* 'mason.nvim' install directory has been added to `PATH`.
--
-- When `vim.lsp.enable` is called, it checks whether `vim.lsp.Config.cmd` is
-- executable. This means that `vim.lsp.Config.cmd` must be in PATH.
--
-- Unfortunately this is not mentioned in docs; there is likely an assumption
-- of no lazy-loading and/or LSPs being installed via a package manager rather
-- than through a Neovim plugin.
require("peter.util.lazy").on_load("mason.nvim", function()
  local languages = require("peter.util.languages")

  languages.for_each(function(_, cfg)
    if cfg.lsp then
      vim.lsp.enable(cfg.lsp)
    end
  end)
end)

lsp.delete_global_defaults()

lsp.on_attach(function(client, bufnr)
  lsp.set_default_keymaps(client, bufnr)

  if client:supports_method("textDocument/codeLens") then
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
      group = autocmds.augroup("RefreshCodeLens"),
      desc = "Refresh CodeLens",
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end
end)

do
  -- Store active progress tokens for all running clients.
  local active_tokens_by_client = {}

  vim.api.nvim_create_autocmd("LspProgress", {
    group = autocmds.augroup("LspProgressCodeLens"),
    desc = "Refresh CodeLens whenever the LSP becomes idle",
    callback = function(ev)
      local client_id = ev.data.client_id
      local client = vim.lsp.get_client_by_id(client_id)

      if not client or not client:supports_method("textDocument/codeLens") then
        return
      end

      local value = ev.data.params.value
      local token = ev.data.params.token

      if not (value and token) then
        return
      end

      -- stylua: ignore
      active_tokens_by_client[client_id] = active_tokens_by_client[client_id] or {}

      -- Active tokens for the current client.
      local active_tokens = active_tokens_by_client[client_id]

      if value.kind == "begin" then
        active_tokens[token] = true
      elseif value.kind == "end" then
        active_tokens[token] = nil

        -- Check if all tokens are done.
        for _, active in pairs(active_tokens) do
          if active then
            return
          end
        end

        -- No more progress; the LSP is idle.
        active_tokens_by_client[client_id] = nil
        vim.lsp.codelens.refresh()
      end
    end,
  })
end
