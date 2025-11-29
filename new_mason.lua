local _ = require("mason-core.functional")
local registry = require("mason-registry")

local function get_mason_map()
  local package_to_lspconfig = {}

  for _, pkg_spec in ipairs(registry.get_all_package_specs()) do
    local lspconfig = vim.tbl_get(pkg_spec, "neovim", "lspconfig")
    if lspconfig then
      package_to_lspconfig[pkg_spec.name] = lspconfig
    end
  end

  return {
    package_to_lspconfig = package_to_lspconfig,
    lspconfig_to_package = _.invert(package_to_lspconfig),
  }
end

local mapping = get_mason_map()

---@diagnostic disable-next-line: unused-local
registry.refresh(vim.schedule_wrap(function(sucess, updated_registries)
  registry.register_package_aliases(_.map(function(server_name)
    return { server_name }
  end, mapping.package_to_lspconfig))
end))

local function map_name(name)
  return mapping.lspconfig_to_package[name] or name
end

local function install(name)
  name = map_name(name)
  local p = registry.get_package(name)
  vim.schedule(function()
    p:install()
  end)
end

local function install_all(tbl)
  vim.iter(tbl):each(function(p)
    install(p)
  end)
end

install_all({ "lua_ls" })
-- install_all({ "lua_ls", "angularls", "awk_ls" })
