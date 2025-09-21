---@module "lazy"
---@diagnostic disable: missing-fields

-- Linting.
-- See 'https://github.com/mfussenegger/nvim-lint'.

---@class peter.lint.Opts
---@field events? string[] Events to trigger linting. Default: `{ "BufReadPost", "BufWritePost", "InsertLeave" }`.
---@field linters_by_ft? table<string,string[]> Map of filetypes to list of linters to run. Use `["*"]` for linters to run on *all* filetypes, for example 'cspell'.
---@field linters? table<string,peter.lint.Linter> Map of linters to their properties.
---@field enabled_at_start? boolean Whether linting autocmd should be enabled on start. Default: `true`.

---Linter class extended with the `on_lint` field.
---@class peter.lint.Linter : lint.Linter
---@field on_lint? fun(ctx:peter.lint.ctx):any Pre-lint hook called with a context object. Returning `false` disables the linter; returning `true` or `nil` allows it.

---@class peter.lint.ctx
---@field bufnr integer
---@field filename string
---@field cwd string
---@field ft string

---@type LazyPluginSpec[]
return {
  {
    "mfussenegger/nvim-lint",
    dependencies = { "folke/snacks.nvim" },

    event = { "BufReadPost" },

    ---@type peter.lint.Opts
    opts = {
      -- This should generally by populated in 'lua/peter/languages/*.lua'.
      linters_by_ft = {},

      -- Linter customisation should be done here.
      linters = {
        selene = {
          on_lint = function(ctx)
            return vim.fs.find(
              { "selene.toml" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
        actionlint = {
          on_lint = function(ctx)
            local parent = vim.fs.dirname(ctx.filename)
            return vim.endswith(parent, "/.github/workflows")
          end,
        },
      },

      enabled_at_start = false,
    },

    ---@param opts peter.lint.Opts
    config = function(_, opts)
      local lint = require("lint")

      -- Resolve `opts`.
      local events = opts.events
        or { "BufReadPost", "BufWritePost", "InsertLeave" }
      local linters_by_ft = opts.linters_by_ft or {}
      local linters = opts.linters or {}

      local enabled = opts.enabled_at_start
      if enabled == nil then
        enabled = true
      end

      -- Set linter properties.
      for linter, properties in pairs(linters) do
        for property, details in pairs(properties) do
          lint.linters[linter][property] = details
        end
      end

      -- Handle special case.
      local linters_for_all_ft = linters_by_ft["*"] or {}
      linters_by_ft["*"] = nil
      lint.linters_by_ft = linters_by_ft

      ---Function that extends builtin linter resolution logic.
      local callback = function()
        ---@type peter.lint.ctx
        local ctx = {
          bufnr = vim.api.nvim_get_current_buf(),
          filename = vim.api.nvim_buf_get_name(0),
          ft = vim.bo.filetype,
          cwd = vim.fn.getcwd(),
        }

        -- This is the builtin linter resolution logic.
        local linters_for_ft = lint._resolve_linter_by_ft(ctx.ft)

        -- Filter using the `on_lint` property.
        linters_for_ft = vim
          .iter(linters_for_ft)
          :filter(function(name)
            local hook = opts.linters[name] and opts.linters[name].on_lint
            return not hook or hook(ctx) ~= false
          end)
          :totable()

        if vim.bo.modifiable and vim.bo.buftype ~= "prompt" then
          lint.try_lint(linters_for_ft)
          lint.try_lint(linters_for_all_ft)
        end
      end

      local group = require("peter.util.autocmds").augroup("Linting")

      if enabled then
        vim.api.nvim_create_autocmd(events, {
          group = group,
          callback = callback,
        })
      end

      local all_linters = vim
        .iter(linters_by_ft)
        :fold({}, function(acc, _, _linters)
          acc = vim.list_extend(acc, _linters)
          return acc
        end)

      -- TODO: Refactor so this keymap is available before the plugin has been loaded?
      require("snacks").toggle
        .new({
          name = "Linting",
          set = function(state)
            vim.api.nvim_clear_autocmds({ group = group })

            if state then
              -- Enable linting.
              vim.api.nvim_create_autocmd(events, {
                group = group,
                callback = callback,
              })
              vim.schedule(callback)
            else
              -- Disable linting.
              for _, linter in ipairs(all_linters) do
                local ns = lint.get_namespace(linter)
                vim.diagnostic.reset(ns)
              end
            end

            enabled = not enabled
          end,
          get = function()
            return enabled
          end,
        })
        :map("<leader>ul")
    end,
  },
}
