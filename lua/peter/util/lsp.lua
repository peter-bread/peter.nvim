---LSP Utility functions.
---@class peter.util.lsp
local M = {}

---Helper functions. Defined after API functions.
local H = {}

---@class peter.util.lsp.ResolveSpec
---@field builtin peter.util.lsp.FunctionSpec vim.lsp.buf.*
---@field snacks? peter.util.lsp.FunctionSpec Snacks.picker.*
---
---@alias peter.util.lsp.FunctionSpec string|peter.util.lsp.FunctionSource
---
---@class peter.util.lsp.FunctionSource Define a function with config.
---@field name string Basename of function to call.
---@field opts? table Options table to configure the function's behaviour.

---@alias peter.util.lsp.KeymapOpts vim.keymap.set.Opts|{has?:string|string[], mode?:string|string[]}

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ------------------- START OF PUBLIC API FUNCTIONS. ------------------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Run `callback` when LSP attaches.
---@param callback fun(client: vim.lsp.Client, bufnr: integer):nil Function to be called when LSP attaches.
---@return integer
function M.on_attach(callback)
  -- TODO: Add optional augroup.
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local bufnr = ev.buf
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then
        callback(client, bufnr)
      end
    end,
  })
end

---Run `callback` when LSP attaches *if* the client supports `method`.
---@param method string
---@param callback fun(client:vim.lsp.Client, bufnr:integer)
function M.on_supports_method(method, callback)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local bufnr = ev.buf
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client:supports_method(method) then
        callback(client, bufnr)
      end
    end,
  })
end

---Delete global LSP keymaps.
---See: 'https://neovim.io/doc/user/lsp.html#lsp-defaults-disable'.
function M.delete_global_defaults()
  local del = vim.keymap.del

  del({ "n", "v" }, "gra") -- Code action.
  del("n", "gri") -- Implementation.
  del("n", "grn") -- Rename.
  del("n", "grr") -- References.
  del("n", "grt") -- Type definition.

  del("n", "gO") -- Document symbols.
  del("i", "<C-s>") -- Signature help.
end

---Resolve LSP functions. First attempts to use plugins, and falls back to
---builtin functions in `vim.lsp.buf.*`.
---
---Currently, only 'snacks.nvim' is supported. Other plugins like 'telescope.nvim'
---and 'fzf-lua' will only supported if I ever decide to use them instead of
---'snacks.nvim'.
---
---Usage:
---
--- ```lua
--- -- import
--- local resolve_function = require("peter.util.lsp").resolve_function
--- ```
---
---```lua
--- -- Try to use `snacks.picker.lsp_definitions`, otherwise fallback to
--- -- `vim.lsp.buf.definitions`.
--- local definitions = resolve_function({
---   snacks = "lsp_definitions",
---   builtin = "definitions", -- required
--- })
---
--- -- Use builtin `vim.lsp.buf.hover`, but pass in additional options to
--- -- alter its behaviour.
--- local hover = resolve_function({
---   builtin = { -- required
---     name = "hover",
---     opts = { max_width = 15 },
---   },
--- })
---
--- -- The following are equivalent. Both return `vim.lsp.buf.hover`:
--- local hover = resolve_function({
---   builtin = "hover",
--- })
---
--- local hover = resolve_function({
---   builtin = {
---     name = "hover",
---   },
--- })
---```
---
---See:
--- - [`snacks.nvim`](https://github.com/folke/snacks.nvim)
--- - [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
--- - [`fzf-lua`](https://github.com/ibhagwan/fzf-lua)
---@param opts peter.util.lsp.ResolveSpec -- TODO: Proper class/type for this table.
function M.resolve_function(opts)
  ---@type fun()|nil
  local fn

  -- TODO: Better validation.

  if opts.snacks then
    local ok, snacks = pcall(require, "snacks")
    if type(opts.snacks) == "string" then
      fn = ok and snacks.picker[opts.snacks] or nil
    else
      fn = ok
          and function()
            snacks.picker[opts.snacks.name](opts.snacks.opts)
          end
        or nil
    end
  end

  ---@type fun()
  local builtin

  if type(opts.builtin) == "string" then
    builtin = vim.lsp.buf[opts.builtin]
  else
    builtin = function()
      vim.lsp.buf[opts.builtin.name](opts.builtin.opts)
    end
  end

  return fn or builtin
end

---Check whether a client supports *all* `methods` in a list.
---@param client vim.lsp.Client
---@param methods string|string[]
---@return boolean
function M.supports_all(client, methods)
  return not H.check_methods(client, methods, function(supported)
    return not supported
  end)
end

---Check whether a client supports *any* `methods` in a list.
---@param client vim.lsp.Client
---@param methods string|string[]
---@return boolean
function M.supports_any(client, methods)
  return H.check_methods(client, methods, function(supported)
    return supported
  end)
end

---Create an LSP keymap.
---@param client vim.lsp.Client
---@param bufnr integer
---@param lhs string
---@param rhs function
---@param opts? vim.keymap.set.Opts|{has?:string|string[], mode?:string|string[]}
function M.set_keymap(client, bufnr, lhs, rhs, opts)
  opts = opts or {}

  local mode = opts.mode or "n"
  local has = opts.has or nil

  opts.mode = nil
  opts.has = nil

  if opts.desc then
    opts.desc = "LSP " .. opts.desc
  end

  opts.buffer = bufnr

  if not has then
    vim.keymap.set(mode, lhs, rhs, opts)
    return
  end

  if not M.supports_all(client, has) then
    return
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

---Set default LSP keymaps.
---@param client vim.lsp.Client
---@param bufnr integer
function M.set_default_keymaps(client, bufnr)
  local function map(lhs, rhs, opts)
    M.set_keymap(client, bufnr, lhs, rhs, opts)
  end

  -- stylua: ignore start
  map("K", M.resolve_function({
    builtin = {
      name = "hover",
      opts = { max_height = 15, border = "solid" }
    }
  }), {
    desc = "Hover",
    has = "textDocument/hover",
  })

  map("gd", M.resolve_function({ snacks = "lsp_definitions", builtin = "definition" }), {
    desc = "Definition",
    has = "textDocument/definition",
  })

  map("gr", M.resolve_function({ snacks = "lsp_references", builtin = "references" }), {
    desc = "References",
    has = "textDocument/references",
  })

  map("gI", M.resolve_function({ snacks = "lsp_implementations", builtin = "implementation" }), {
    desc = "Implementation",
    has = "textDocument/implementation",
  })

  map("gy", M.resolve_function({ snacks = "lsp_type_definitions", builtin = "type_definition" }), {
    desc = "Type Definition",
    has = "textDocument/typeDefinition",
  })

  map("gD", M.resolve_function({ snacks = "lsp_declarations", builtin = "declaration" }), {
    desc = "Declaration",
    has = "textDocument/declaration",
  })

  map("gO", M.resolve_function({
    snacks = {
      name = "lsp_symbols",
      -- opts = { tree = false },
    },
    builtin = "document_symbol"
  }), {
    desc = "Symbols",
    has = "textDocument/documentSymbol",
  })

  map("<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code Action",
    has = "textDocument/codeAction",
  })

  map("<leader>cc", vim.lsp.codelens.run, {
    desc = "Run Codelens",
    mode = { "n", "v" },
    has = "textDocument/codeLens",
  })

  map("<leader>cr", vim.lsp.buf.rename, {
    desc = "Rename",
    has = "textDocument/rename",
  })
  -- stylua: ignore end

  if client:supports_method("textDocument/rename") then
    require("peter.util.lazy").on_load("which-key.nvim", function()
      require("which-key").add({
        mode = { "n" },
        { "<leader>c", group = "code" },
      })
    end)
  end

  if client:supports_method("textDocument/codeAction") then
    require("peter.util.lazy").on_load("which-key.nvim", function()
      require("which-key").add({
        mode = { "n", "v" },
        { "<leader>c", group = "code" },
      })
    end)
  end
end

--[[ ---------------------------------------------------------------------- ]]
--
--[[ ---------- END OF API FUNCTIONS. START OF HELPER FUNCTIONS. ---------- ]]
--
--[[ ---------------------------------------------------------------------- ]]

---Check LSP method support.
---@param client vim.lsp.Client
---@param methods string|string[]
---@param predicate fun(supported: boolean): boolean
---@return boolean
function H.check_methods(client, methods, predicate)
  if type(methods) == "string" then
    methods = { methods }
  end

  for _, method in ipairs(methods) do
    local supported = client:supports_method(method)
    if predicate(supported) then
      return true
    end
  end

  return false
end

return M
