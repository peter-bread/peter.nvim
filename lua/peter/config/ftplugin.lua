local languages = require("peter.util.languages")

---@param ftplugin peter.lang.config.ftplugin
local function create_ft_autocmd(ftplugin)

  ---@type string
  local name

  if type(ftplugin.ft) ~= "string" or type(ftplugin.ft) ~= "table" then
    return
  end

  local capitalise = require("peter.util.strings").capitalise
  local augroup = require("peter.util.autocmds").augroup

  if type(ftplugin.ft) == "string" then
    name = capitalise(ftplugin.ft --[[@as string]])
  else
    name = table.concat(vim.tbl_map(capitalise, ftplugin.ft --[[@as table<string>]]))
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("Lang" .. name),
    pattern = ftplugin.ft,
    callback = ftplugin.callback,
  })
end

languages.for_each(function(_, cfg)
  if cfg.ftplugin then
    create_ft_autocmd(cfg.ftplugin)
  end
end)
