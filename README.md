# nvim

Personal Neovim configuration. Lua-based, [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins, [mason.nvim](https://github.com/williamboman/mason.nvim) for LSP/DAP/linters.

## Install

```sh
git clone <this-repo> ~/.config/nvim
nvim
```

First launch bootstraps `lazy.nvim` and installs plugins. Run `:Mason` to install language servers.

## Requirements

- Neovim ≥ 0.10 (uses `vim.uv`)
- `git`, `make`, a C compiler (for treesitter)
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- `ripgrep`, `fd` for telescope/fuzzy search

## Layout

```
init.lua            entry; bootstraps lazy.nvim
lua/
  options.lua       vim.opt settings
  mappings.lua      keymaps
  autocmds.lua      autocommands
  utils.lua
  plugins/          plugin specs (ai, ui, editor, completion, ...)
  configs/          per-plugin setup (cmp, mason, vimtex, ...)
ftplugin/           per-filetype settings (rust, python, tex, ...)
ftdetect/           filetype detection (csv, env, mdx)
lazy-lock.json      pinned plugin revisions
```

## Updating

```vim
:Lazy sync
:Mason
```
