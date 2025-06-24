---@module "lazy"

-- better a/i text-objects
--

---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.ai",
    event = { "BufReadPost", "BufNewFile" },

    -- TODO: finish configuring
    opts = {},
  },
}
