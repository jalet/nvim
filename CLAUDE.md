# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal Neovim configuration forked from kickstart.nvim, reorganized into a modular structure. All config is Lua.

## Lua Style

Formatting is enforced by **StyLua** (runs on save via conform.nvim). Settings in `.stylua.toml`:
- 2-space indent, 160 column width, single quotes preferred, no call parentheses

When editing Lua files, match the existing style: `require('foo').setup { ... }` (space before brace, no parens around single-table args).

## Architecture

**Entry point:** `init.lua` sets leader keys and the yank-highlight autocmd, then `require 'jj.plugins'`.

**Plugin loading:** Neovim 0.12's native `vim.pack`. `lua/jj/plugins/init.lua` declares the full plugin list in one `vim.pack.add {...}` call (dependency-ordered), registers a `PackChanged` autocmd for build hooks (`:TSUpdate` for treesitter, `make` for telescope-fzf-native), and then `require`s each per-plugin setup module.

**Key structural decisions:**
- `plugin/options.lua` and `plugin/terminal.lua` are auto-sourced by Neovim's runtime -- options, keymaps, and terminal autocmds live here. Note these run *after* `init.lua`, so values needed during plugin setup (`vim.g.have_nerd_font`) are also set at the top of `init.lua`.
- Each file in `lua/jj/plugins/<name>.lua` is a plain configuration module: it runs `require('plug').setup {...}` (or equivalent) at top level and returns nothing. The plugin list lives in `lua/jj/plugins/init.lua`, not the individual files.
- LSP servers use Neovim 0.11+ native config: each server has a file in `lsp/<server_name>.lua` returning a config table (settings, filetypes, etc.) or `{}`
- `lua/jj/plugins/blink-cmp.lua` calls `vim.lsp.config('*', ...)` for global capabilities and `vim.lsp.enable({...})` to activate all servers
- Mason + mason-tool-installer auto-install LSP servers; formatters/linters/debug adapters are installed manually via `:Mason` (see `TODO.md`)
- `folke/lazydev.nvim` provides Neovim API completions for Lua files (replaces neodev.nvim)
- Completion uses **blink.cmp**
- `vim.pack` has no lazy-loading DSL; most plugins load eagerly at startup. Use autocmds for filetype/event deferral when needed.

**Formatting pipeline (conform.nvim):**
- Lua: `stylua`
- Go: `gci` then `gofumpt` (both write to disk, autocmd reloads buffer for Go files under `~/projects/fever.energy`)
- JS/TS: `prettierd`
- Format-on-save is enabled globally with 500ms timeout, LSP fallback

## Adding a New Plugin

1. Add an entry to the `vim.pack.add {...}` list in `lua/jj/plugins/init.lua` (ordered after its dependencies).
2. If the plugin needs configuration, create `lua/jj/plugins/<name>.lua` that runs `require('<plug>').setup {...}` at top level, and add a `require 'jj.plugins.<name>'` line to the require block in `lua/jj/plugins/init.lua`.
3. If the plugin needs a build step, add a branch to the `PackChanged` autocmd in `lua/jj/plugins/init.lua`.

## Adding a New LSP Server

1. Create `lsp/<server_name>.lua` returning a config table (or `return {}` for defaults)
2. Add the server name to the `vim.lsp.enable` list in `lua/jj/plugins/blink-cmp.lua`
3. Add the Mason package name to `ensure_installed` in `lua/jj/plugins/mason.lua`

## Key Bindings to Know

Leader is `<Space>`. Keymaps are defined across `plugin/options.lua` (general), `lua/jj/plugins/blink-cmp.lua` (LSP-attach), `lua/jj/plugins/telescope.lua` (search), and `lua/jj/plugins/debug.lua` (DAP). The pattern is `<leader>` + mnemonic: `sf` = Search Files, `sg` = Search Grep, `ca` = Code Action, `f` = Format, `o` = Oil file explorer.
