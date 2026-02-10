local languages = require("peter.util.languages")

local function validate(ft)
  if type(ft) ~= "string" and type(ft) ~= "table" then
    vim.notify(
      "Skipping FileType autocmd: `type(ft) = "
        .. type(ft)
        .. "`. It should be `string` or `table`.",
      vim.log.levels.ERROR,
      { title = "ftplugin" }
    )
    return false
  end

  if type(ft) == "string" then
    if ft == "" then
      vim.notify(
        "Skipping FileType autocmd: empty filetype provided",
        vim.log.levels.ERROR,
        { title = "ftplugin" }
      )
      return false
    end
  else
    for _, f in ipairs(ft) do
      if f == "" then
        vim.notify(
          "Skipping FileType autocmd: empty filetype found in list",
          vim.log.levels.ERROR,
          { title = "ftplugin" }
        )
        return false
      end
    end
  end

  return true
end

---@param ftplugin peter.lang.ftplugin
local function create_ft_autocmd(ftplugin)
  local ft = ftplugin.ft

  if not validate(ft) then
    return
  end

  local capitalise = require("peter.util.strings").capitalise
  local augroup = require("peter.util.autocmds").augroup

  ---@type string
  local name

  if type(ft) == "string" then
    name = capitalise(ft)
  else
    name = table.concat(vim.tbl_map(capitalise, ft))
  end

  if name == "" then
    vim.notify(
      "Skipping FileType autocmd: empty augroup name",
      vim.log.levels.WARN,
      { title = "ftplugin" }
    )
    return
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
