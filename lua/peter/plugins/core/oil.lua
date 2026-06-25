---@module "lazy"
---@module "oil"

-- File explorer.
-- See 'https://github.com/stevearc/oil.nvim'.

---@type LazyPluginSpec[]
return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    ---@type oil.SetupOpts
    opts = {
      columns = { "icon", "type", "permissions", "size", "mtime" },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<localleader>|"] = { "actions.select", opts = { vertical = true } },
        ["<localleader>-"] = { "actions.select", opts = { horizontal = true } },
        ["<C-r>"] = { "actions.refresh" },

        -- TODO: Run shell command with current oil item as argument.
        -- ["<C-x>"] = function()
        --   local oil = require("oil")
        --
        --   local dir = oil.get_current_dir()
        --
        --   local entry = oil.get_cursor_entry()
        --   if not entry then
        --     return
        --   end
        --
        --   local path = dir .. entry.name
        --
        --   vim.ui.input({ prompt = "Command: " }, function(input)
        --     local cmd_str = input .. " " .. path
        --     local cmd = vim.split(cmd_str, " ", { trimempty = true })
        --
        --     vim.system(cmd, {}, function(out)
        --       vim.print(out.stdout)
        --       vim.print(out.stderr)
        --       if out.code ~= 0 then
        --         vim.print("Exited with " .. out.code)
        --       end
        --     end)
        --   end)
        -- end,
      },
    },
  },
}
