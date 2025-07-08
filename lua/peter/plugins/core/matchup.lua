---@module "lazy"

-- better matching (using %)
-- https://github.com/andymass/vim-matchup

---@type LazyPluginSpec[]
return {
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },

    -- set options using vim.g.matchup_<option> = <value>
    init = function() end,
  },
}
