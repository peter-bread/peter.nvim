---@module "lazy"

-- better a/i text-objects
--

---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.ai",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = true
      },
    },
    event = { "BufReadPost", "BufNewFile" },

    -- TODO: finish configuring
    opts = {},
  },
}
