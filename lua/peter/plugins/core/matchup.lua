---@module "lazy"

-- better matching (using %)
-- https://github.com/andymass/vim-matchup

---@type LazyPluginSpec[]
return {
  {
    -- TODO: revert to main plugin once treesitter PR is merged. See below.
    -- "andymass/vim-matchup",

    -- HACK: `vim-matchup` still depends on nvim-treesitter#master.
    -- This fork has removed that dependency.
    -- See:
    -- - https://github.com/andymass/vim-matchup/pull/390
    -- - https://github.com/andymass/vim-matchup/pull/330
    url = "https://github.com/TheLeoP/vim-matchup",
    branch = "update-treesitter",

    event = { "BufReadPost", "BufNewFile" },

    init = function()
      vim.g.matchup_treesitter_enabled = true
    end,
  },
}
