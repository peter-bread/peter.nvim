local uv = vim.uv
local fn = vim.fn

local lazy_path = fn.stdpath("data") .. "/lazy"
local output_file = fn.stdpath("config") .. "/generated.luarc.json"

local function is_dir(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory"
end

local function scan_lazy_plugins()
  local libraries = {}

  local handle = uv.fs_scandir(lazy_path)
  if not handle then
    print("Could not scan lazy directory: " .. lazy_path)
    return libraries
  end

  while true do
    local name, type = uv.fs_scandir_next(handle)
    if not name then
      break
    end

    if type == "directory" then
      local lua_dir = lazy_path .. "/" .. name .. "/lua"
      if is_dir(lua_dir) then
        table.insert(libraries, lua_dir)
      end
    end
  end

  return libraries
end

local function generate_config()
  local libraries = scan_lazy_plugins()

  vim.list_extend(libraries, {
    "/opt/homebrew/Cellar/neovim/0.11.4/share/nvim/runtime/lua",
    "/Users/petersheehan/.config/peter.nvim/lua",
    -- "${3rd}/luv/library",
    "$HOME/LLS_Addons/luvit-meta",
  })

  local config = {
    ["$schema"] = "https://raw.githubusercontent.com/LuaLS/vscode-lua/refs/heads/master/setting/schema.json",
    runtime = {
      path = { "?.lua", "?/init.lua" },
      pathStrict = true,
      version = "LuaJIT",
    },
    workspace = {
      checkThirdParty = false,
      ignoreDir = { "/lua", "./temp" },
      library = libraries,
    },
  }

  local json = fn.json_encode(config)

  local file = io.open(output_file, "w")
  if not file then
    print("Failed to open output file: " .. output_file)
    return
  end

  file:write(json)
  file:close()

  print("Generated LuaLS config at: " .. output_file)
end

generate_config()
