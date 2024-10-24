-- for more sources:
-- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

return {
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",
  lazy = true,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local ls = require("luasnip")

    cmp.setup({
      enabled = function()
        if vim.g.cmp_status then
          if vim.g.cmp_status == "force_enabled" then
            return true
          elseif vim.g.cmp_status == "force_disabled" then
            return false
          end
        end

        local ctx = require("cmp.config.context")

        -- Always enable completion in command mode
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        end

        -- Disable completion in comments
        if
          ctx.in_treesitter_capture("comment") or ctx.in_syntax_group("Comment")
        then
          return false
        end

        -- Disable completion in prompt buffers (e.g. telescope prompts)
        if vim.bo.buftype == "prompt" then
          return false
        end

        -- Disable completion when recording or executing macros
        if vim.fn.reg_recording() ~= "" or vim.fn.reg_executing() ~= "" then
          return false
        end

        -- Enable completion in all other cases
        return true
      end,
      snippet = {
        expand = function(arg)
          ls.lsp_expand(arg.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-n>"] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Select,
        }),
        ["<C-p>"] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Select,
        }),
        ["<C-y>"] = cmp.mapping.confirm({
          behavior = cmp.SelectBehavior.Select,
          select = true,
        }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = function()
            return math.floor(0.45 * vim.o.columns)
          end,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            buffer = "[Buffer]",
            path = "[Path]",
          },
        }),
      },
    })

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.jumpable(1) then
        ls.jump(1)
      end
    end, { silent = true, desc = "Snippet Jump Next" })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = "Snippet Jump Prev" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true, desc = "Cycle Snippet Choice" })

    vim.keymap.set("n", "<leader>cS", function()
      local status_map = {
        standard = {
          next_status = "force_enabled",
          message = "cmp status: force_enabled",
        },
        force_enabled = {
          next_status = "force_disabled",
          message = "cmp status: force_disabled",
        },
        force_disabled = {
          next_status = "standard",
          message = "cmp status: standard",
        },
      }

      if vim.g.cmp_status and status_map[vim.g.cmp_status] then
        local next_state = status_map[vim.g.cmp_status]
        vim.g.cmp_status = next_state.next_status
        vim.notify(next_state.message, vim.log.levels.INFO)
      end
    end, { desc = "Cycle cmp Status" })

    -- `/` cmdline setup
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
