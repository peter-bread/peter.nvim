---@module "lazy"

-- Better matching (using %).
-- See 'https://github.com/andymass/vim-matchup'.

---@type LazyPluginSpec[]
return {
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },

    -- Set options using `vim.g.matchup_<option> = <value>`.
    init = function() end,
  },
}
