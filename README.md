# peter.nvim

> [!WARNING]
> Currently undergoing a rewrite.
> None of the information on this page can be considered accurate.

---

<!-- markdownlint-disable MD033 -->

<!-- <div align="center"> -->
<!--   <a href="https://github.com/peter-bread/peter.nvim/issues?q=is%3Aissue+is%3Aopen+label%3AP0"> -->
<!--     <img alt="GitHub Issues or Pull Requests by label" -->
<!--     src="https://img.shields.io/github/issues/peter-bread/peter.nvim/P0?style=for-the-badge&label=Priorities"> -->
<!--   </a> -->
<!-- </div> -->

<!-- markdownlint-restore -->

My modular, relatively minimal Neovim config for MacOS and Linux.

---

## Requirements

<!-- markdownlint-disable MD013 -->

- [`git`](https://git-scm.com/)
- [Neovim](https://neovim.io/) 0.11+ (and it's dependencies)
- Fuzzy finding ([`snacks.picker`](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)):
  - [`fd`](https://github.com/sharkdp/fd)
  - [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- Installing dev tools ([`mason.nvim`](https://github.com/mason-org/mason.nvim)):
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

<!-- Generate filetree using `tree` CLI tool -->

The entry point is the top-level [`init.lua`](./init.lua).

The majority of configuration can be found in [`lua/peter/`](./lua/peter/).

<!-- markdownlint-disable MD013 -->

```text
lua/peter/
├── config/                   # Main configuration module
│   ├── autocmds.lua            - General autocmds
│   ├── diagnostic.lua          - Diagnostic settings and icons
│   ├── filetypes.lua           - Add custom filetypes
│   ├── ftplugin.lua            - Set up filetype-specific behaviour (from language config)
│   ├── globals.lua             - Global functions (for debugging only)
│   ├── init.lua                - Entry point for config module
│   ├── keymaps.lua             - Set keymaps
│   ├── lazy.lua                - Bootstrap and configure lazy.nvim plugin manager
│   ├── lsp.lua                 - Set up LSP (from language config)
│   └── options.lua             - Set global variables and options
├── languages/                # Language configs
│   ├── init.lua                - Builds table that maps languages to configs
│   └── lua.lua                 - Lua config (example)
├── plugins/                  # Plugins
│   ├── core                    - General plugins
│   ├── lsp                     - LSP related plugins
│   ├── mini                    - Plugins from mini.nvim
│   └── snacks                  - Modules from snacks.nvim
└── util/                     # Utility functions
```

There is additional configuration in [`after/`](./after/).

```text
after/
├── ftplugin/                 # Filetype-specific behaviour (NOT from language config)
└── lsp/                      # LSP server configurations
```

<!-- markdownlint-restore -->

### Languages

Programming languages are managed in [`lua/peter/languages/<language>.lua`](./lua/peter/languages/).
Each of these files should return a table of type `peter.lang.config`. The type
is defined in [`lua/peter/languages/init.lua`](./lua/peter/languages/init.lua)
and shown below:

```lua
---@class (exact) peter.lang.config
---@field lsp? string[] List of LSP servers to be enabled.
---@field plugins? LazyPluginSpec[] Plugins to be installed.
---@field ftplugin? peter.lang.config.ftplugin Buffer-specific options and config.

---@class (exact) peter.lang.config.ftplugin
---@field ft string|string[] Filetype(s) to run `callback` on.
---@field callback fun(args: vim.api.keyset.create_autocmd.callback_args)
```

There is also still the option to use [`after/ftplugin/<filetype>.lua`](./after/ftplugin/)
to set buffer-specific options. However, it can be easier to use the table approach
above as `ftplugin.ft` *can* be a list, so you can apply the same options to
multiple filetypes while only writing the code once, for example [Haskell and
Cabal files](https://github.com/mrcjkb/haskell-tools.nvim#zap-quick-setup).

When populating the `plugins` field, it is useful to use the accompanying
utility functions, found in [`lua/peter/util/plugins/languages.lua`](./lua/peter/util/plugins/languages.lua).
These remove some of the boilerplate code for extending the options of commonly
used plugins.

Language configs are processed in [`lua/peter/languages/init.lua`](./lua/peter/languages/init.lua).
This builds and exposes a table which maps language names to configurations.
This table can be accessed with:

```lua
-- whole table
local languages = require("peter.languages")

-- just lua config
local lua_config = require("peter.languages").lua
local lua_config = require("peter.languages")["lua"]

```

To make working with this table easier, utility functions are provided in
[`lua/peter/util/languages.lua`](./lua/peter/util/languages.lua).

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
    L.format({ lua = { "stylua" } }),  -- register formatter
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
    L.format({ lua = { "stylua" } }),  -- register formatter
  },
}
```

```lua
-- after/ftplugin/lua.lua

vim.bo.shiftwidth = 4
```

Allowing both methods provides the most flexibilty. The first approach enables
proper centralisation of language configuration. The second approach follows a
more traditional structure.

### LSP

LSP servers are configured separately. LSP configuration is done in one of two
places:

1. [`after/lsp/<lsp_server>.lua`](./after/lsp/)
2. `.nvim/lsp/<lsp_server>.lua` (for project-local config, if `exrc` is enabled)

In the second case, make sure `vim.o.exrc = true` and that you also create
`.nvim.lua` with the following code:

```lua
-- .nvim.lua

vim.cmd([[set runtimepath+=.nvim]])
```

These files should each return a table of type `vim.lsp.Config`.
The [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) plugin is used
to provide sane default configurations for all language servers. As a user, you
can overwrite or extend these configurations in `after/lsp/<lsp_server>.lua`.

> [!WARNING]
>
> See [here](https://github.com/neovim/nvim-lspconfig/issues/3705) for LSP servers
> that are not (yet) compatible with `vim.lsp.{enable,config}`. These servers need
> to be set up with `require("lspconfig")[server_name].setup(server_cfg)`.
> Currently, this is not supported in this Neovim config. This will only
> be supported if I ever need to use one of these LSP servers, which is
> unlikely.

## Missing Functionality

This config is a bit more minimal than my [previous config](https://github.com/peter-bread/peter.nvim/tree/nvim-v0.10).
Below is a list of features that are not currently implemented in this config.
Some of these were in my previous config, others were not.

<details>
  <summary>Linting</summary>

  I haven't got round to this yet. Usually LSP + formatter is enough
  for me, but I plan on adding this back at some point.

  Plugins:

  - [nvim-lint](https://github.com/mfussenegger/nvim-lint)

</details>

<details>
  <summary>Git Integration</summary>

  I need to decide how much git integration is needed inside Neovim. How much
  do I need to do in Neovim vs what can I do from a terminal.

  Plugins:
  - Git
    - [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
    - [fugitive](https://github.com/tpope/vim-fugitive)
    - [neogit](https://github.com/NeogitOrg/neogit)
    - [diffview.nvim](https://github.com/sindrets/diffview.nvim)
    - [mini.git](https://github.com/echasnovski/mini-git)
    - [mini.diff](https://github.com/echasnovski/mini.diff)
    - [snacks.lazygit](https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md)
  - GitHub
    - [octo.nvim](https://github.com/pwntester/octo.nvim)

</details>

<details>
  <summary>Statusline</summary>
</details>

<details>
  <summary>Dashboard</summary>
</details>


<details>
  <summary>flash.nvim</summary>
</details>

<details>
  <summary>Custom snippets</summary>
</details>

<details>
  <summary>Markdown</summary>
</details>

<!-- - bullets.vim -->
<!-- - markview.nvim / render-markdown.nvim -->

<details>
  <summary>Debugging</summary>
</details>

<details>
  <summary>File Explorer</summary>
</details>

<details>
  <summary>Org-mode</summary>
</details>
