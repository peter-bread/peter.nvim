-- Extra configuration only when in Neovim config directory.
-- This replaces '.nvim.lua' as I want these settings across all machines.

local neovim = require("peter.util.neovim")

if not neovim.is_in_neovim_config_dir() then
  return
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

vim.cmd([[set runtimepath+=.nvim]])

local set = vim.keymap.set

-------------------------------------------------------------------- Help Keymap

local help = function(surrounding)
  vim.cmd('noautocmd silent normal! "zyi' .. surrounding)
  local cmd = vim.trim(vim.fn.getreg("z"))

  if cmd:match("^:%s*h[e]?[l]?[p]?[g]?[r]?[e]?[p]?%s") then
    pcall(vim.api.nvim_command, cmd)
  end

  vim.schedule(function()
    vim.fn.setreg("z", "")
  end)
end

vim.keymap.set("n", "<leader>h", function()
  help("`")
end, { desc = "Run nvim help commands inside backticks.", silent = true })

--------------------------------------------------------------- Execute Lua Code

set("n", "<leader>x", ":.lua<cr>", { desc = "Execute Lua" })
set("v", "<leader>x", ":lua<cr>", { desc = "Execute Lua" })

set("n", "<leader>X", ":luafile %<cr>", { desc = "Execute Lua file" })

--------------------------------------------------------------- Languages Picker

local function languages()
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    return
  end

  local files = require("peter.util.files")

  snacks.picker.pick({
    source = "files",
    title = "Languages",
    cwd = vim.fn.stdpath("config") .. "/lua/peter/languages",

    ---@diagnostic disable-next-line: unused-local
    layout = function(source)
      ---@type snacks.picker.layout.Config
      return {
        preset = "select",
        layout = {
          width = 0.2,
          height = 0.65,
          min_width = 30,
          border = "solid",
        },
      }
    end,

    transform = function(item, _)
      item.text = files.strip_extension(item.text, "lua")
      if item.text == "init" then
        return false
      end
      return item
    end,

    format = function(item, _)
      return {
        { files.strip_extension(item.file, "lua"), "SnacksPickerFile" },
      }
    end,
  })
end

set("n", "<leader>nl", languages, { desc = "Languages" })

--------------------------------------------------------- Neovim which-key Group

require("peter.util.lazy").on_load("which-key.nvim", function()
  require("which-key").add({
    mode = { "n" },
    { "<leader>n", desc = "neovim" },
  })
end)
