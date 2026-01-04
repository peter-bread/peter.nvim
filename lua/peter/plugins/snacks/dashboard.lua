---@module "lazy"
---@module "snacks"

-- Dashboard.
-- See 'https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md'.

local P = require("peter.util.plugins.plugins")

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
         =\     /=                                                                        /\     
           )===(            ██████╗ ███████╗████████╗███████╗██████╗      .        /\_/\  / /     
          /     \           ██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗             / o o \ \ \    *
          |     |           ██████╔╝█████╗     ██║   █████╗  ██████╔╝           ===  Y  === /     
   '     /       \          ██╔═══╝ ██╔══╝     ██║   ██╔══╝  ██╔══██╗           /         \/      
         \       /          ██║     ███████╗   ██║   ███████╗██║  ██║           \ | | | | /       
          \_   _/           ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝            `|_|-|_|'        
     █████\ \█████████████████████████████████████████████████████████████████████████████    
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
    action = function()
      require("snacks").dashboard.pick("files")
    end,
  },
  {
    -- icon = " ",
    icon = " ",
    key = "r",
    desc = "Recent Files",
    action = function()
      require("snacks").dashboard.pick("oldfiles")
    end,
  },
  {
    icon = "󱎸 ",
    key = "g",
    desc = "Grep",
    action = function()
      require("snacks").dashboard.pick("live_grep")
    end,
  },
  {
    icon = " ",
    key = "G",
    desc = "Git",
    action = ":Neogit", -- This will load Neogit.
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
    action = ":qa",
  },
}

---@type snacks.dashboard.Config
---@diagnostic disable-next-line: missing-fields
local cfg = {
  preset = {
    header = header,
    keys = keys,
  },
  sections = {
    { section = "header" },
    { section = "keys", padding = 1 },
    { section = "recent_files" },
  },
}

---@type LazyPluginSpec[]
return {
  P.snacks({ dashboard = cfg }),
}
