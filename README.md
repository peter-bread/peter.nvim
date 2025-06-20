# peter.nvim

> [!WARNING]
> Currently undergoing a rewrite.
> None of the information on this page can be considered accurate.

---

<!-- markdownlint-disable MD033 -->

<div align="center">
  <a href="https://github.com/peter-bread/peter.nvim/issues?q=is%3Aissue+is%3Aopen+label%3AP0">
    <img alt="GitHub Issues or Pull Requests by label"
    src="https://img.shields.io/github/issues/peter-bread/peter.nvim/P0?style=for-the-badge&label=Priorities">
  </a>
</div>

<!-- markdownlint-restore -->

My first proper Neovim config.

> [!NOTE]
> Intended for use on MacOS and Linux.

## Requirements

> [!NOTE]
> I don't think this list is exhaustive right now, hopefully one day it will be!

<!-- markdownlint-disable MD013 -->

- [`git`](https://git-scm.com/)
- Neovim 0.11+ (and it's dependencies)
- Fuzzy finding ([snacks.picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)):
  - [`fd`](https://github.com/sharkdp/fd)
  - [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- Installing dev tools ([mason.nvim](https://github.com/mason-org/mason.nvim)):
  - General:
    - `git`
    - `curl` or `GNU wget`
    - `unzip`
    - `tar` (or `gtar`)
    - `gzip`
  - External language runtimes & package managers:
    - [ruby](https://www.ruby-lang.org/en/): `ruby`, `gem`
    - [go](https://go.dev/): `go`
    - [java](https://openjdk.org/): `java`, `javac`
    - [python](https://www.python.org/): `python`, `pip`, `venv`
    - [rust](https://www.rust-lang.org/): `cargo`
    - [node.js](https://nodejs.org/en): `node`, `npm`
- Language Parsers ([`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter/tree/main)):
  - `tar`
  - `curl`
  - [`tree-sitter`](https://github.com/tree-sitter/tree-sitter) CLI (0.25.0+)
  - a C compiler (e.g. `cc`, `gcc`, `clang`)
  - `node` (23.0.0+)

<!-- markdownlint-restore -->

## Install

Clone the repository:

```sh
git clone https://github.com/peter-bread/peter.nvim.git ~/.config/nvim
```

If you carefully manage environment variables:

```sh
git clone https://github.com/peter-bread/peter.nvim.git "$XDG_CONFIG_HOME/$NVIM_APPNAME"
```

If you use `gh` CLI:

```sh
gh repo clone peter-bread/peter.nvim ~/.config/nvim
```

```sh
gh repo clone peter-bread/peter.nvim "$XDG_CONFIG_HOME/$NVIM_APPNAME"
```

> [!TIP]
> Be sure to back up any existing Neovim files.

## Structure

### General

The entry point is the top-level `init.lua`.

The majority of configuration can be found in `lua/peter/`.

There is additional configuration in `after/`.

```text
lua/peter/
|-- config/
|   |-- autocmds.lua
|   |-- filetypes.lua
|   |-- init.lua
|   |-- keymaps.lua
|   |-- lazy.lua
|   |-- options.lua
|-- languages/ (not done yet. more detail will be in Languages section)
|-- plugins/
|   |-- core/
|   |-- mini/
|   |-- lsp/
|-- util/
|-- types.lua
```

```text
after/
|-- ftplugin/
|-- lsp/
```

### Languages

Programming languages are managed in `lua/peter/languages/<language>.lua`. Each
of these files should return a table of type `peter.lang.config`. The type is
defined below:

```lua
---@class peter.lang.config
---@field lsp? string[] List of LSP servers to be enabled.
---@field plugins? LazyPluginSpec[] Plugins to be installed.
---@field ftplugin? peter.lang.config.ftplugin Buffer-specific options and config.

---@class peter.lang.config.ftplugin
---@field ft string|string[] Filetype(s) to run `callback` on.
---@field callback fun(args: vim.api.keyset.create_autocmd.callback_args)
```

There is also still the option to use `after/ftplugin/<filetype>.lua` to set
buffer-specific options.

When populating the `plugins` field, it will be useful to use the accompanying
utility functions, found in `lua/peter/util/plugins/languages.lua`. These remove
some of the boilerplate code for extending the options of commonly used plugins.

Language configs are processed in `lua/peter/languages/init.lua`. This creates
a table which maps language name to its configuration. This table can be accessed
with:

```lua
-- whole table
require("peter.languages")

-- just lua config
require("peter.languages").lua

-- or
require("peter.languages")["lua"]
```

To make working with this table easier, utility functions are provided in
`lua/peter/util/languages.lua`.

Example config to set up the Lua programming language:

```lua
-- lua/peter/languages/lua.lua

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "lua_ls" }, -- enable lua language server

  plugins = {
    L.treesitter({ "lua", "luadoc" }), -- install parsers
    L.mason({ "lua_ls", "stylua" }),   -- install LSP and formatter
  },

  ftplugin = {
    ft = "lua", -- run on lua files
    callback = function() -- function to be executed for each lua file
      vim.bo.shiftwidth = 4
    end,
  },
}
```

If you prefer to use `after/ftplugin`, you can split this config into two files:

```lua
-- lua/peter/languages/lua.lua

local L = require("peter.util.plugins.languages")

---@type peter.lang.config
return {
  lsp = { "lua_ls" }, -- enable lua language server

  plugins = {
    L.treesitter({ "lua", "luadoc" }), -- install parsers
    L.mason({ "lua_ls", "stylua" }),   -- install LSP and formatter
  },
}
```

```lua
-- after/ftplugin/lua.lua

vim.bo.shiftwidth = 4
```
