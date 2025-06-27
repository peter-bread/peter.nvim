---@module "lazy"
---@module "snacks"
---@module "which-key"

---@type snacks.picker.Config
local cfg = {
  enabled = true,

  ---@diagnostic disable-next-line: unused-local
  layout = function(source)
    -- TODO: dynamic layouts based on size (vim.o.columns)
    return "general"
  end,

  -- TODO: make more layouts for other sizes
  layouts = {
    general = {
      layout = {
        box = "horizontal",
        width = 0.9,
        min_width = 120,
        height = 0.75,
        border = "solid",
        [1] = {
          box = "vertical",
          border = "solid",
          title = "{title} {live} {flags}",
          title_pos = "center",
          [1] = { win = "input", height = 1, border = "bottom" },
          [2] = { win = "list", border = "solid", wo = { scrolloff = 4 } },
        },
        [2] = {
          win = "preview",
          title = "{preview}",
          title_pos = "center",
          border = "solid",
          width = 0.6,
          wo = {
            relativenumber = false,
            foldcolumn = "0",
            signcolumn = "no",
            statuscolumn = "%{v:lnum}",
          },
        },
      },
    },
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

local P = require("peter.util.plugins.plugins")

return {
  -- stylua: ignore
  P.snacks({ picker = cfg }, {
    -- general
    { "<leader>S", require("snacks").picker.pick, desc = "Search" },

    -- find
    { "<leader>ff", pick("files"), desc = "Files" },
    { "<leader>fF", pick("files", { hidden = true, ignored = true }), desc = "All Files" },
    { "<leader>fr", pick("recent"), desc = "Recent" },

    -- search
    { "<leader>sg", pick("grep"), desc = "Grep" },
    { "<leader>ss", pick("lsp_symbols"), desc = "LSP Symbols" },
  }),

  P.which_key({
    mode = { "n" },
    { "<leader>f", group = "find" },
    { "<leader>s", group = "search" },
  }),
}
