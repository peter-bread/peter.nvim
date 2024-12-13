---@diagnostic disable: missing-fields

---@module "snacks"

local header = [[
                                     *     ,MMM8&&&.            *                                 
                 '                        MMMM88&&&&&    .                                      ' 
*                                        MMMM88&&&&&&&                                            
                             *           MMM88&&&&&&&&                        *                   
                                         MMM88&&&&&&&&                                            
        .                                'MMM88&&&&&&'                                      .     
                                '          'MMM8&&&'      *                                       
          |\___/|                                                     '                           
          )     (       .                       *                                                 
         =\     /=                                                                        /\     
           )===(          ██████╗ ███████╗████████╗███████╗██████╗        .        /\_/\  / /     
          /     \         ██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗               / o o \ \ \    *
          |     |         ██████╔╝█████╗     ██║   █████╗  ██████╔╝             ===  Y  === /     
   '     /       \        ██╔═══╝ ██╔══╝     ██║   ██╔══╝  ██╔══██╗             /         \/      
         \       /        ██║     ███████╗   ██║   ███████╗██║  ██║             \ | | | | /       
          \__  _/         ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝.nvim         `|_|-|_|'        
     ██████( (██████████████████████████████████████████████████████████████████████████████    
             ) )                                                                                  
            ( (                                                                                   
             )_)                                                                                  
]]

---@type snacks.dashboard.Item[]
local keys = {
  {
    icon = " ",
    key = "f",
    desc = "Find File",
    action = ":lua Snacks.dashboard.pick('files')",
  },
  {
    icon = "󱎸 ",
    key = "g",
    desc = "Search Text",
    action = function()
      require("telescope.builtin").live_grep()
    end,
  },
  {
    icon = " ",
    key = "r",
    desc = "Recent Files",
    action = function()
      require("telescope.builtin").oldfiles()
    end,
  },
  {
    icon = "󰒲 ",
    key = "l",
    desc = "Lazy",
    action = ":Lazy",
    enabled = package.loaded.lazy ~= nil,
  },
  {
    icon = " ",
    key = "q",
    desc = "Quit",
    action = function()
      vim.api.nvim_input("<cmd>qa<cr>")
    end,
  },
}

-- local colours = require("kanagawa.colors").setup()
-- local palette = colours.palette
-- local theme = colours.theme
-- --
-- vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = palette.autumnRed })

---@type snacks.dashboard.Config
local M = {
  enabled = true,
  width = 40,
  row = nil,
  col = nil,
  pane_gap = 4,
  preset = {
    header = header,
    keys = keys,
  },
  sections = {
    { section = "header" },
    { section = "keys", gap = 1, padding = 2 },
    { section = "startup" }, -- TODO: format this (remove icons)
  },
}

return M
