local M = {}

---Configuration for dashboard center buttons
---@return table actions The buttons that will be on the dashboard
function M.center()
  ---Add padding before text
  ---@param desc string text to be padded
  ---@return string padded_desc text that has been padded
  ---Example:
  ---
  ---   pad("hello") -> "    hello"
  local function pad(desc)
    return string.rep(" ", 4) .. desc
  end

  return {
    {
      action = require("telescope.builtin").find_files,
      desc = pad("Find File"),
      icon = " ",
      key = "f",
    },
    {
      action = "ene | startinsert",
      desc = pad("New File"),
      icon = " ",
      key = "n",
    },
    {
      action = require("telescope.builtin").live_grep,
      desc = pad("Search Text"),
      icon = "󱎸 ",
      key = "g",
    },
    {
      action = require("telescope.builtin").oldfiles,
      desc = pad("Recent Files"),
      icon = " ",
      key = "r",
    },
    {
      action = "Lazy",
      desc = pad("Lazy"),
      icon = "󰒲 ",
      key = "l",
    },
    {
      action = function()
        vim.api.nvim_input("<cmd>qa<cr>")
      end,
      desc = pad("Quit"),
      icon = " ",
      key = "q",
    },
  }
end

M.logos = {}

M.logos.wide_cats = [[
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

M.logos.compact_cats = [[
                 *     ,MMM8&&&.            *      
                      MMMM88&&&&&    .             
                     MMMM88&&&&&&&                 
         *           MMM88&&&&&&&&                 
                     MMM88&&&&&&&&                 
                     'MMM88&&&&&&'                 
                       'MMM8&&&'      *            
               |\___/|                             
               )     (             .              '
              =\     /=                   /\       
                )===(       *     /\_/\  / /       
               /     \           / o o \ \ \       
               |     |         ===  Y  === /       
              /       \        /         \/        
              \       /        \ | | | | /         
               \__  _/          `|_|-|_|'          
    ██████╗ █████( (████████╗███████╗██████╗       
    ██╔══██╗██╔═══) )══██╔══╝██╔════╝██╔══██╗      
    ██████╔╝█████( (   ██║   █████╗  ██████╔╝      
    ██╔═══╝ ██╔══╝)_)  ██║   ██╔══╝  ██╔══██╗      
    ██║     ███████╗   ██║   ███████╗██║  ██║      
    ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝.nvim 
]]

return M
