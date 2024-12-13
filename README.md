# peter.nvim

![GitHub Issues or Pull Requests by label](https://img.shields.io/github/issues/peter-bread/peter.nvim/P0?style=for-the-badge&label=Priorities&link=https%3A%2F%2Fgithub.com%2Fpeter-bread%2Fpeter.nvim%2Fissues%3Fq%3Dis%253Aissue%2Bis%253Aopen%2Blabel%253AP0)

---

My first proper Neovim config.

> [!NOTE]
> Intended for use on MacOS and Linux.

## Requirements

> [!NOTE]
> I don't think this list is exhaustive right now, hopefully one day it will be!

<!-- markdownlint-disable MD013 -->

- git
- lua
- neovim (+ it's dependencies)
- [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep) (for telescope)
- any tools needed to install or run tools from mason:
  - node
  - cargo
  - python
  - go
  - ruby
  - java

<!-- markdownlint-restore -->

## Install

Clone the repository.

```sh
git clone https://github.com/peter-bread/peter.nvim.git ~/.config/nvim
```

> [!TIP]
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

## Showcase

<img width="1697" alt="Screenshot 2024-09-19 at 00 20 07" src="https://github.com/user-attachments/assets/ff34bc6c-7e95-424c-87cd-594cc20a2707">  
<img width="1697" alt="Screenshot 2024-09-19 at 00 22 11" src="https://github.com/user-attachments/assets/1f354be7-3fda-4515-badd-0bb6c93243f9">
