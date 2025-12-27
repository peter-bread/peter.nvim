---@module "lazy"
---@module "snacks"

--
-- See 'https://github.com/folke/snacks.nvim/blob/main/docs/gh.md'.

local P = require("peter.util.plugins.plugins")

---@type snacks.gh.Config
---@diagnostic disable-next-line: missing-fields
local gh = {}

---@type snacks.picker.Config
--- Customise GitHub pickers.
local picker = {
  sources = {
    gh_issue = {},
    gh_pr = {},
  },
}

---Wrapper function to make config cleaner.
---@param source string Picker to use.
---@param opts? snacks.picker.Config Picker options.
---@return function
local function pick(source, opts)
  return function()
    require("snacks").picker.pick(source, opts)
  end
end

---@type LazyPluginSpec[]
return {
  P.snacks({ gh = gh, picker = picker }, {
    -- stylua: ignore start
    { "<leader>gi", pick("gh_issue"), desc = "GitHub Issues (open)" },
    { "<leader>gI", pick("gh_issue", { state  = "all" }), desc = "GitHub Issues (all)" },
    { "<leader>gp", pick("gh_pr"), desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", pick("gh_pr", { state  = "all" }), desc = "GitHub Pull Requests (all)" },
  }),
}
