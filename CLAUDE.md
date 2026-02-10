# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal Neovim configuration forked from kickstart.nvim, reorganized into a modular structure. All config is Lua.

## Lua Style

Formatting is enforced by **StyLua** (runs on save via conform.nvim). Settings in `.stylua.toml`:
- 2-space indent, 160 column width, single quotes preferred, no call parentheses

When editing Lua files, match the existing style: `require('foo').setup { ... }` (space before brace, no parens around single-table args).

## Architecture

**Entry point:** `init.lua` bootstraps lazy.nvim and loads all plugin specs from `lua/jj/plugins/`.

**Plugin loading:** lazy.nvim auto-discovers specs via `require('lazy').setup 'jj.plugins'` -- every `.lua` file in `lua/jj/plugins/` is a lazy.nvim plugin spec (returns a table or list of tables).

**Key structural decisions:**
- `plugin/options.lua` and `plugin/terminal.lua` are auto-sourced by Neovim's runtime (not lazy.nvim) -- options, keymaps, and terminal autocmds live here
- LSP servers use Neovim 0.11+ native config: each server has a file in `lsp/<server_name>.lua` returning a config table (settings, filetypes, etc.) or `{}`
- `lua/jj/plugins/lsp.lua` calls `vim.lsp.config('*', ...)` for global capabilities and `vim.lsp.enable({...})` to activate all servers
- Mason + mason-tool-installer auto-install LSP servers; formatters/linters/debug adapters are installed manually via `:Mason` (see `TODO.md`)
- `folke/lazydev.nvim` provides Neovim API completions for Lua files (replaces neodev.nvim)
- Completion uses **blink.cmp** (active); nvim-cmp exists but is `enabled = false`
- Avante (AI plugin) is fully commented out; Claude Code plugin is active

**Formatting pipeline (conform.nvim):**
- Lua: `stylua`
- Go: `gci` then `gofumpt` (both write to disk, autocmd reloads buffer for Go files under `~/projects/fever.energy`)
- JS/TS: `prettierd`
- Format-on-save is enabled globally with 500ms timeout, LSP fallback

## Adding a New Plugin

Create `lua/jj/plugins/<name>.lua` returning a lazy.nvim spec table. It will be auto-loaded.

## Adding a New LSP Server

1. Create `lsp/<server_name>.lua` returning a config table (or `return {}` for defaults)
2. Add the server name to the `vim.lsp.enable` list in `lua/jj/plugins/lsp.lua`
3. Add the Mason package name to `ensure_installed` in the mason-tool-installer config in `lua/jj/plugins/lsp.lua`

## Key Bindings to Know

Leader is `<Space>`. Keymaps are defined across `plugin/options.lua` (general), `lua/jj/plugins/lsp.lua` (LSP-attach), `lua/jj/plugins/telescope.lua` (search), and `lua/jj/plugins/debug.lua` (DAP). The pattern is `<leader>` + mnemonic: `sf` = Search Files, `sg` = Search Grep, `ca` = Code Action, `f` = Format, `o` = Oil file explorer.
