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
    action = function()
      require("snacks").dashboard.pick("files")
    end,
  },
  {
    icon = "󱎸 ",
    key = "g",
    desc = "Search Text",
    action = function()
      require("snacks").dashboard.pick("live_grep")
    end,
  },
  {
    icon = " ",
    key = "r",
    desc = "Recent Files",
    action = function()
      require("snacks").dashboard.pick("oldfiles")
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
    action = ":qa",
  },
}

---@type snacks.dashboard.Config
local Config = {
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
    { section = "keys", gap = 1 },

    -- { section = "startup", icon = "", padding = { 0, 4 } },

    function()
      local stats = require("lazy.stats").stats()

      local ms = math.floor(stats.startuptime * 100 + 0.5) / 100

      ---@type snacks.dashboard.Section
      return {
        align = "center",
        text = {
          { "loaded ", hl = "footer" },
          { stats.loaded .. "/" .. stats.count, hl = "special" },
          { " plugins in ", hl = "footer" },
          { ms .. " ms", hl = "special" },
        },
        padding = { 0, 4 },
      }
    end,
  },
}

return {
  {
    "folke/snacks.nvim",

    ---@type snacks.Config
    opts = {
      dashboard = Config,
    },
  },
}
