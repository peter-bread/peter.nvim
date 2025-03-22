---@diagnostic disable: missing-fields

---@module "blink.cmp"

local constants = require("peter.constants")
local paths = constants.paths
local sensitive = paths.sensitive

local patterns = require("peter.util.patterns")
local matches_all = patterns.matches_all
local get_sensitive_message = patterns.get_sensitive_message

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "v0.*",

    -- WARN: build from main (be careful of breaking changes)
    -- build = "cargo +nightly build --release",

    dependencies = {
      { "rafamadriz/friendly-snippets", lazy = true },
      { "L3MON4D3/LuaSnip", lazy = true },
    },

    ---@type blink.cmp.Config
    opts = {

      keymap = {
        preset = "none",

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },

      signature = {
        enabled = true,
        window = {
          show_documentation = false,
        },
      },

      snippets = { preset = "luasnip" },

      completion = {
        trigger = {
          show_on_accept_on_trigger_character = false,
          show_on_x_blocked_trigger_characters = { "," },
        },

        list = {
          selection = { preselect = true, auto_insert = false },
        },

        accept = {
          auto_brackets = { enabled = true },
        },

        menu = {
          winblend = vim.o.pumblend,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
              { "source_name" },
            },
            components = {
              source_name = {
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
                end,
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      sources = {
        default = { "lsp", "snippets", "path" },
        providers = {
          path = {
            transform_items = function(_, items)
              if vim.g.hide_sensitive_files then
                local Kind = require("blink.cmp.types").CompletionItemKind
                for _, item in ipairs(items) do
                  ---@type string
                  local path = item.data.full_path

                  local message = get_sensitive_message(path)
                  if message and item.kind == Kind.File then
                    item.documentation = { value = message }
                  end
                end
              end
              return items
            end,
          },
        },
      },
    },
  },
}
