---@module "lazy"
---@module "blink.cmp"

---@type LazyPluginSpec[]
return {
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    version = "v1.*",

    -- WARN: build from main (be careful of breaking changes)
    -- build = "cargo +nightly build --release",

    opts_extend = { "sources.default" },

    ---@type blink.cmp.Config
    opts = {

      sources = {
        default = { "lsp", "snippets", "path" },
      },

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

      snippets = { preset = "default" },

      completion = {
        trigger = {},

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

        documentation = {},
      },
    },
  },
}
