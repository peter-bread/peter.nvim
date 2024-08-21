# peter.nvim

My first proper Neovim config.

> [!NOTE]
> Intended for use on MacOS and Linux.

## Install

### Dotfiles

> [!CAUTION]
>
> This is not yet supported.
>
> Working on it though!!!

This can be installed automatically with the rest of my [`dotfiles`](https://github.com/peter-bread/.dotfiles)
using [this script](https://github.com/peter-bread/bootstrap/blob/main/bootstrap.sh).

Run the following command:

<!-- markdownlint-disable MD013 -->

```bash
curl -sL https://raw.githubusercontent.com/peter-bread/bootstrap/main/bootstrap.sh | bash
```

<!-- markdownlint-restore -->

### Standalone

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

You can use `require("util.new_lang)` to access a wrapper module that simplifies
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
