if vim.fn.has("nvim-0.11") ~= 1 then
  vim.notify_once(
    "peter.nvim requires Neovim 0.11 or above. "
      .. "Current version: "
      .. require("peter.util.version").string()
      .. ". "
      .. "Upgrade if possible."
      .. "\n"
      .. "Altervatively, checkout an older tagged version of the config (not recommended).",
    vim.log.levels.ERROR
  )
  return
end

require("peter.config")
