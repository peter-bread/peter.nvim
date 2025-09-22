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
---@field condition? fun(ctx:peter.lint.ctx):any Function to dynamically enable/disable a linter, called with a context object. Returning `false` disables the linter; returning anything else or `nil` allows it.
---@field process_diagnostics? fun(diagnostic:vim.Diagnostic):vim.Diagnostic? Function to process diagnostics produced by a linter.

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
          condition = function(ctx)
            return vim.fs.find(
              { "selene.toml" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
        actionlint = {
          condition = function(ctx)
            local parent = vim.fs.dirname(ctx.filename)
            return vim.endswith(parent, "/.github/workflows")
          end,
        },
      },

      enabled_at_start = false,
    },

    ---@param opts peter.lint.Opts?
    config = function(_, opts)
      local lint = require("lint")

      -- Resolve `opts`.
      local config = vim.tbl_deep_extend("force", {}, {
        events = { "BufReadPost", "BufWritePost", "InsertLeave" },
        linters_by_ft = {},
        linters = {},
        enabled_at_start = true,
      }, opts or {})

      -- Set linter properties.
      for name, properties in pairs(config.linters) do
        -- No type annotations for these helper funcions.
        -- There are very annoying conflicts between `lint.Linter` and
        -- `peter.lint.Linter`. It's easier to treat them as the same
        -- class (they pretty much are anyway) and forgo type annotations.

        ---Modify a linter's properties.
        local function apply_properties(linter)
          for property, value in pairs(properties) do
            if property ~= "process_diagnostics" then
              linter[property] = value
            end
          end
          return linter
        end

        ---Wrap linter to post-process diagnostics.
        local function wrap_if_needed(linter)
          if properties.process_diagnostics then
            return require("lint.util").wrap(
              linter,
              properties.process_diagnostics
            )
          end
          return linter
        end

        local linter = lint.linters[name]

        -- First apply all properties apart from `process_diagnostics`.
        -- The linter can only be wrapped after all other properties have been
        -- set.

        if type(linter) == "table" then
          linter = apply_properties(linter)
          linter = wrap_if_needed(linter)
          --
        elseif type(linter) == "function" then
          local original = lint.linters[name]
          linter = function()
            local _linter = original()
            _linter = apply_properties(_linter)
            return _linter
          end
          linter = wrap_if_needed(linter)
        end

        lint.linters[name] = linter
      end

      -- Handle special case.
      local linters_for_all_ft = config.linters_by_ft["*"] or {}
      config.linters_by_ft["*"] = nil
      lint.linters_by_ft = config.linters_by_ft

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

        -- Filter using the `condition` property.
        linters_for_ft = vim
          .iter(linters_for_ft)
          :filter(function(name)
            local linter = lint.linters[name] --[[@as peter.lint.Linter|fun():peter.lint.Linter]]

            if type(linter) == "function" then
              linter = linter()
            end

            local condition = linter and linter.condition
            return not condition or condition(ctx) ~= false
          end)
          :totable()

        if vim.bo.modifiable and vim.bo.buftype ~= "prompt" then
          lint.try_lint(linters_for_ft)
          lint.try_lint(linters_for_all_ft)
        end
      end

      local group = require("peter.util.autocmds").augroup("Linting")

      if config.enabled then
        vim.api.nvim_create_autocmd(config.events, {
          group = group,
          callback = callback,
        })
      end

      local all_linters = vim
        .iter(lint.linters_by_ft)
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
              vim.api.nvim_create_autocmd(config.events, {
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

            config.enabled = not config.enabled
          end,
          get = function()
            return config.enabled
          end,
        })
        :map("<leader>ul")
    end,
  },
}
