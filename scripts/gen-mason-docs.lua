---@diagnostic disable: unused-local, unused-function

if not (type(vim) == "table" and type(vim.api) == "table") then
  local name = arg and arg[0]
  print("Error: this script must be run from a Neovim process.")
  print("Use the following command:")
  print(string.format("nvim --headless '+luafile %s' +qa", name))
  return
end

local Registry = require("mason-registry")
local Purl = require("mason-core.purl")

---@deprecated
---This is not used as it could include packages that are not declared in the
---plugin spec.
local function get_installed_map()
  local pkg_specs = Registry.get_all_package_specs()
  return vim
    .iter(pkg_specs)
    :filter(function(pkg_spec)
      return Registry.is_installed(pkg_spec.name)
    end)
    :map(function(pkg_spec)
      local id = pkg_spec.source.id
      local purl = Purl.parse(id)
      return { [pkg_spec.name] = purl.value.type }
    end)
    :fold({}, function(acc, t)
      for k, v in pairs(t) do
        acc[k] = v
      end
      return acc
    end)
end

local function get_requested_map()
  local ok, tpmti = pcall(require, "thirdparty.mason-tool-installer")
  if not ok then
    return nil
  end

  return vim
    .iter(tpmti.get_ensure_installed_names())
    :map(function(name)
      local pkg = Registry.get_package(name)
      local id = pkg.spec.source.id
      local purl = Purl.parse(id)
      return { [name] = purl.value.type }
    end)
    :fold({}, function(acc, t)
      for k, v in pairs(t) do
        acc[k] = v
      end
      return acc
    end)
end

local function flip_map(map)
  return vim.iter(map):fold({}, function(acc, name, source)
    acc[source] = acc[source] or {}
    table.insert(acc[source], name)
    return acc
  end)
end

local map = get_requested_map()
local flipped = flip_map(map)

-- Sorting is required to keep output deterministic.

-- Sort each list in `flipped`.
for _, pkgs in pairs(flipped) do
  table.sort(pkgs)
end

-- Create sorted keys.
local types = {}
for t in pairs(flipped) do
  table.insert(types, t)
end
table.sort(types)

local file = io.open("MASON.md", "w")
if file then
  file:write([[# Mason

This is a mapping of purl types to package names.

From this, it should be fairly straightforward to deduce which tools are required to download, build and run any of the packages.

The packages in this document are extracted from `ensure_installed` in the `mason.nvim` plugin spec.
]])

  for _, t in ipairs(types) do
    file:write("\n")
    file:write(string.format("## %s\n", t))
    file:write("\n")
    for _, pkg in ipairs(flipped[t]) do
      file:write(string.format("- %s\n", pkg))
    end
  end

  file:close()
end
