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
    key = "f",
    desc = "Find File",
    action = function()
      require("snacks").dashboard.pick("files")
    end,
  },
  {
    key = "r",
    desc = "Recent Files",
    action = function()
      require("snacks").dashboard.pick("oldfiles")
    end,
  },
  {
    key = "g",
    desc = "Grep",
    action = function()
      require("snacks").dashboard.pick("live_grep")
    end,
  },
  {
    key = "G",
    desc = "Git",
    action = ":Neogit", -- This will load Neogit.
  },
  {
    key = "l",
    desc = "Lazy",
    action = ":Lazy",
    enabled = package.loaded.lazy ~= nil,
  },
  {
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
