---@module "lazy"

-- Autopairs.
-- See 'https://github.com/windwp/nvim-autopairs'.
--
-- Currently using this instead of 'mini.pairs' as it is more powerful OOTB.
-- See 'https://github.com/nvim-mini/mini.pairs'.

---@type LazyPluginSpec[]
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },
}
