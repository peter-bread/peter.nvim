-- autopairs
-- https://github.com/windwp/nvim-autopairs
--
-- currently use this instead of mini.pairs as it is more powerful OOTB

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },
}
