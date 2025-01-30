---@diagnostic disable: missing-fields

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    -- version = "v0.*",

    -- TODO: revert to version after f0f34c318af019b44fc8ea347895dcf92b682122
    -- is included in a versioned release
    -- This should be the next release after v0.11.0

    branch = "main",

    -- WARN: build from main (be careful of breaking changes)
    build = "cargo +nightly build --release",

    dependencies = {
      { "rafamadriz/friendly-snippets", lazy = true },
      { "L3MON4D3/LuaSnip", lazy = true },
    },

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {

      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },

      signature = { enabled = true },

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
      },
    },
  },
}
