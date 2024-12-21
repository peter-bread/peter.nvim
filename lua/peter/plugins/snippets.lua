return {
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    lazy = true,
    config = function()
      -- load all snippets defined in snippets directory in neovim config
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = "./snippets",
      })

      -- TODO: find project root, check for .vscode, iterate through and load
      -- any *.code-snippet files dynamically

      -- load project-local snippets
      -- right now, the file must *ALWAYS* be named `project.code-snippets`
      require("luasnip.loaders.from_vscode").load_standalone({
        path = ".vscode/project.code-snippets",
      })
    end,
  },
}
