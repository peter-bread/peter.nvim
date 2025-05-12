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

- git
- neovim (+ it's dependencies)
- [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep) (for snacks.picker)
- any tools needed to install or run tools from mason:
  - node
  - cargo
  - python
  - go
  - ruby
  - java

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

### Languages

Programming languages are configured in two places:

<!-- markdownlint-disable MD013 -->

- [`lua/plugins/languages`](https://github.com/peter-bread/peter.nvim/tree/main/lua/peter/plugins/languages): plugin configuration
- [`after/ftplugin`](https://github.com/peter-bread/peter.nvim/tree/main/after/ftplugin): extra configuration (e.g. `vim.bo`, snippets\*)

You can use [`require("peter.util.new_lang")`](https://github.com/peter-bread/peter.nvim/blob/main/lua/peter/util/new_lang.lua) to access a wrapper module that simplifies
some plugin setup for progamming languages.

<!-- markdownlint-restore -->

It is useful for:

- treesitter (installing parsers)
- mason (package manager for external editor tooling, e.g. lsp, formatters, etc.)
- lspconfig (setting up LSP)
- format (setting up formatting)
- lint (setting up linting)
- test (set up testing)
- dap (set up debugging)

On top of that, you can include other plugins, but you need to set them up manually.

## License

Licensed under [MIT](./LICENSE), feel free to use any parts you like.

Code taken from other external projects is detailed [here](./THIRD_PARTY.md).

---

\* Snippets can also be set in `snippets/snippets/<language>.json` (global) and
`.vscode/*.code-snippets` (project-specific.)
