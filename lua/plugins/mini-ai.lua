return {
  "echasnovski/mini.ai",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  opts = function()
    local ai = require("mini.ai")
    return {
      n_lines = 500,
      -- stylua: ignore
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        d = { "%f[%d]%d+" }, -- digits
        e = { -- Word with case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        g = function() -- Whole buffer, similar to `gg` and 'G' motion
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)

    require("util.lazy").on_load("which-key.nvim", function()
      local objects = {
        { " ", desc = "whitespace" },
        { '"', desc = 'balanced "' },
        { "'", desc = "balanced '" },
        { "(", desc = "balanced (" },
        { ")", desc = "balanced ) including white-space" },
        { "<", desc = "balanced <" },
        { ">", desc = "balanced > including white-space" },
        { "?", desc = "user prompt" },
        { "U", desc = "use/call without dot in name" },
        { "[", desc = "balanced [" },
        { "]", desc = "balanced ] including white-space" },
        { "_", desc = "underscore" },
        { "`", desc = "balanced `" },
        { "a", desc = "argument" },
        { "b", desc = "balanced )]}" },
        { "c", desc = "class" },
        { "d", desc = "digit(s)" },
        { "e", desc = "word in CamelCase & snake_case" },
        { "f", desc = "function" },
        { "g", desc = "entire file" },
        { "i", desc = "indent" },
        { "o", desc = "block, conditional, loop" },
        { "q", desc = "quote `\"'" },
        { "t", desc = "tag" },
        { "u", desc = "use/call function & method" },
        { "{", desc = "balanced {" },
        { "}", desc = "balanced } including white-space" },
      }

      local ret = { mode = { "o", "x" } }
      for prefix, name in pairs({
        i = "inside",
        a = "around",
        il = "last",
        ["in"] = "next",
        al = "last",
        an = "next",
      }) do
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
          ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
        end
      end
      require("which-key").add(ret, { notify = false })
    end)
  end,
}
