---@module "lazy"

-- Better a/i text-objects.
-- See 'https://github.com/nvim-mini/mini.ai'.
--
-- See 'https://github.com/nvim-mini/mini.ai/commit/96cd250' for `an/in`
-- conflicts with LSP mappings in Neovim 0.12+.

-- TODO: Deal with these when upgrading to Neovim 0.12 and 0.13 respectively.
-- 4ce4c35 docs(ai): document workarounds for `al` / `il` conflicts on Neovim>=0.13 (3 months ago)
-- a783ce6 docs(ALL): add `vim.pack` and remove 'vim-plug' installation methods (3 months ago)
-- 7e10ce8 docs(ai): better document workarounds for `v_an` / `v_in` conflicts (4 months ago)

---@type LazyPluginSpec[]
return {
  {
    "nvim-mini/mini.ai",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    event = { "BufReadPost", "BufNewFile" },

    opts = function()
      local ai = require("mini.ai")
      return {
        -- stylua: ignore
        custom_textobjects = {
          -- Use builtin text-objects as they seem to handle escaped characters
          -- better.
          -- Continue to use `q` from 'mini.ai' as a convenience, but use these
          -- ones for more complicated strings
          -- ['"'] = false,
          -- ["'"] = false,
          -- ["`"] = false,

          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          F = ai.gen_spec.function_call()
        },
        n_lines = 500,
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)

      -- Register new mapping descriptions.
      -- Using `on_load` instead of a plugin spec as these mappings should
      -- only be listed once 'mini.ai' has loaded.

      require("peter.util.lazy").on_load("which-key.nvim", function()
        local objects = {
          { "(", desc = "() block" },
          { ")", desc = "() block with ws" },
          { "[", desc = "[] block" },
          { "]", desc = "[] block with ws" },
          { "{", desc = "{} block" },
          { "}", desc = "{} block with ws" },
          { "<", desc = "< block" },
          { ">", desc = "> block with ws" },

          { '"', desc = 'balanced "' },
          { "'", desc = "balanced '" },
          { "`", desc = "balanced `" },

          { "?", desc = "user prompt" },

          { "a", desc = "argument" },
          { "b", desc = ")]} block" },
          { "c", desc = "class" },
          { "f", desc = "function" },
          { "F", desc = "function call" },
          { "q", desc = "quote \"'`" },
          { "t", desc = "tag" },
        }

        -- stylua: ignore
        local prefix_groups = {
          { prefix = "a",  group = "around" },
          { prefix = "i",  group = "inside" },
          { prefix = "an", group = "next" },
          { prefix = "in", group = "next" },
          { prefix = "al", group = "last" },
          { prefix = "il", group = "last" },
        }

        local mappings = {
          mode = { "o", "x" },
        }

        for _, pg in ipairs(prefix_groups) do
          mappings[#mappings + 1] = { pg.prefix, group = pg.group }
          for _, obj in pairs(objects) do
            mappings[#mappings + 1] = { pg.prefix .. obj[1], desc = obj.desc }
          end
        end

        require("which-key").add(mappings, { notify = false })
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = true,
    -- NOTE: If this plugin ever needs its own config, consider moving to its
    -- own file.
  },
}
