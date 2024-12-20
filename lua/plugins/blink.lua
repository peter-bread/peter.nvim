---@diagnostic disable: missing-fields

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

      appearance = {
        use_nvim_cmp_as_default = true,
      },

      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
          -- require("blink.cmp.completion.list").hide()
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
          require("blink.cmp.completion.list").hide()
        end,
      },

      completion = {
        trigger = {
          show_on_accept_on_trigger_character = false,
          show_on_x_blocked_trigger_characters = { "," },
        },

        list = {
          selection = "preselect",
        },

        accept = {
          auto_brackets = {
            enabled = true,
          },
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
        default = { "lsp", "luasnip", "path" },
      },
    },
  },
}
