---@module "lazy"

-- better text-objects
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
