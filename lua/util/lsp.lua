local M = {}

-- Inspiration for some functionality:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/lsp.lua

---@alias has string|string[]
---@alias mode string|string[]
---Extension of `vim.keymap.set.Opts`.
---  *`{has}`*   - Capabilities the client must have for *`{rhs}`* to work. Defaults to `nil`.
---  *`{mode}`*  - Mode for the keymap. Same as *`{mode}`* argument in *`vim.keymap.set()`*. Defaults to "n".
---@alias LspMapOpts vim.keymap.set.Opts|{has?:has, mode?:mode}

---Creates an autocmd that runs an `on_attach` function on `LspAttach` events.
---
---   Basically passing in the function to be used
---   as `callback` in `vim.api.nvim_create_autocmd`.
---@param on_attach fun(client: vim.lsp.Client, bufnr: integer):nil Function to be invoked when an LSP server client attaches to a buffer. The function should take two parameters: the client object and the buffer number.
---@param name? string Optional name of LSP server client. Used as a filter, i.e. only define this function if `client.name == name`.
---@return integer Autocmd_ID returned by `vim.api.nvim_create_autocmd`.
function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and (not name or client.name == name) then
        on_attach(client, bufnr)
      end
    end,
  })
end

---Run `fn` when an LSP client attaches if the given `method` is supported.
---@param method string Method/capability that needs to be supported.
---@param fn fun(client: vim.lsp.Client, bufnr: integer) Function to run.
function M.on_supports_method(method, fn)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.supports_method(method) then
        fn(client, bufnr)
      end
    end,
  })
end

---Create LSP keymaps for supported capabilities.
---@param client vim.lsp.Client The LSP client.
---@param bufnr integer Buffer number.
function M.create_lsp_keymaps(client, bufnr)
  ---Create LSP buffer keymaps if `client` ***has*** the capabilities.
  ---@param lhs string Left-hand side of the mapping.
  ---@param rhs string|function Right-hand side of the mapping. Can be a Lua function.
  ---@param opts? LspMapOpts Options. Extends standard *`{opts}`* of *`vim.keymap.set()`* with *`{has}`* and *`{mode}`*. The *`{desc}`* field will be prepended with "LSP ".
  local function map(lhs, rhs, opts)
    -- handle `opts` being nil
    if not opts then
      opts = {}
    end

    -- Mode for keymap.
    -- Defaults to "n". Can be overridden by `opts.mode`.
    local mode = opts.mode or "n"

    -- Capabilities required for keymap.
    -- Defaults to `nil`. Can be overridden by `opts.has`.
    local has = opts.has or nil

    -- prepend "LSP" to keymap description (if provided)
    if opts.desc then
      opts.desc = "LSP " .. opts.desc
    end

    -- must be buffer mapping
    opts.buffer = bufnr

    -- remove mode from opts
    if opts.mode then
      opts.mode = nil
    end

    -- remove has from opts
    if opts.has then
      opts.has = nil
    end

    -- if no capabilities are required then set keymap
    if not has then
      vim.keymap.set(mode, lhs, rhs, opts)
      return
    end

    -- if one capability is required then set keymap
    if type(has) == "string" then
      if client.supports_method(has) then
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      return
    end

    -- check that all required capabilities are suppported
    for _, capability in ipairs(has) do
      if not client.supports_method(capability) then
        return
      end
    end

    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- stylua: ignore start
  map("<leader>cl", "<cmd>LspInfo<cr>", { desc = "Info" })

  map("gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, {
    desc = "Definition",
    has = "textDocument/definition",
  })

  map("gr", require("telescope.builtin").lsp_references, {
    desc = "References",
    has = "textDocument/references",
  })

  map("gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, {
    desc = "Implementation",
    has = "textDocument/implementation",
  })

  map("gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, {
    desc = "Type Definition",
    has = "textDocument/typeDefinition",
  })

  map("gD", vim.lsp.buf.declaration, {
    desc = "Declaration",
    has = "textDocument/declaration",
  })

  map("gK", vim.lsp.buf.signature_help, {
    desc = "Signature Help",
    has = "textDocument/signatureHelp",
  })

  map("<c-k>", vim.lsp.buf.signature_help, {
    desc = "Signature Help",
    mode = "i",
    has = "textDocument/signatureHelp",
  })

  map("<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code Actions",
    has = "textDocument/codeAction",
  })

  map("<leader>cc", vim.lsp.codelens.run, {
    desc = "Run Codelens",
    mode = { "n", "v" },
    has = "textDocument/codeLens",
  })

  map("<leader>cC", vim.lsp.codelens.refresh, {
    desc = "Refresh & Display Codelens",
    has = "textDocument/codeLens",
  })

  map("<leader>cr", vim.lsp.buf.rename, {
    desc = "Rename",
    has = "textDocument/rename",
  })
  -- stylua: ignore end
end

return M
