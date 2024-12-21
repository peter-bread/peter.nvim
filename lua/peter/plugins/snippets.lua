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
      local loader = require("luasnip.loaders.from_vscode")

      -- load all snippets defined in snippets directory in neovim config
      loader.lazy_load({ paths = "./snippets" })

      -- Project root directory
      local root = vim.fs.root(0, { ".git", ".vscode", ".github" })

      if not root then
        return
      end

      -- vscode directory
      local vscode =
        vim.fs.find(".vscode", { type = "directory", path = root })[1]

      if not vscode then
        return
      end

      -- get relative paths to each `*.code-snippets` files
      local handle = vim.uv.fs_scandir(vscode)

      if not handle then
        return
      end

      -- relative paths to *.code-snippets files
      local snippets = {}

      while true do
        local name, type = vim.uv.fs_scandir_next(handle)
        if not name then
          break
        end
        if type == "file" and name:match("%.code%-snippets$") then
          table.insert(snippets, ".vscode/" .. name)
        end
      end

      -- load snippets
      if #snippets > 0 then
        for _, path in ipairs(snippets) do
          loader.load_standalone({ path = path })
        end
      end
    end,
  },
}
