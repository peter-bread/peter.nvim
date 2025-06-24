---@module "lazy"

-- better matching (using %)
-- https://github.com/andymass/vim-matchup

---@type LazyPluginSpec[]
return {
  {
    -- TODO: revert to main plugin once treesitter PR is merged. See below.
    -- "andymass/vim-matchup",

    -- HACK: Latest release and main branch of vim-matchup still depend on
    -- nvim-treesitter/nvim-treesitter@master. Currently I am using main and not
    -- master, so these plugins are incompatible.
    --
    -- This fork has removed that dependency.
    -- See:
    -- - https://github.com/andymass/vim-matchup/pull/390
    -- - https://github.com/andymass/vim-matchup/pull/330

    url = "https://github.com/TheLeoP/vim-matchup",
    branch = "update-treesitter",

    event = { "BufReadPost", "BufNewFile" },

    -- set options using vim.g.matchup_<option> = <value>
    init = function() end,
  },
}
