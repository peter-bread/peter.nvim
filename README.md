# peter.nvim

My first proper Neovim config.

> [!NOTE]
> Intended for use on MacOS and Linux.

## Requirements

<!-- markdownlint-disable MD013 -->

- neovim (+ it's dependencies)
- [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep) (for telescope)

<!-- markdownlint-restore -->

## Install

Clone the repository.

```sh
git clone https://github.com/peter-bread/peter.nvim.git ~/.config/nvim
```

> [!NOTE]
> Be sure to back up any existing Neovim files.

## Structure

### Languages

Programming languages are configured in two places:

<!-- markdownlint-disable MD013 -->

- [`lua/plugins/languages`](https://github.com/peter-bread/peter.nvim/tree/main/lua/plugins/languages): plugin configuration
- [`after/ftplugin`](https://github.com/peter-bread/peter.nvim/tree/main/after/ftplugin): extra configuration (e.g. `vim.bo`, snippets)

<!-- markdownlint-restore -->

You can use `require("util.new_lang")` to access a wrapper module that simplifies
some plugin setup for progamming languages.

It is useful for:

- treesitter (installing parsers)
- mason (package manager for external editor tooling, e.g. lsp, formatters, etc.)
- lspconfig (setting up LSP)
- format (setting up formating)
- lint (setting up linting)
- test (set up testing)
- dap (set up debugging)

On top of that, you can include other plugins, but you need to set them up manually.
