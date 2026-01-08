# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository for `~/.config/` on a Linux desktop. It tracks configuration for: Alacritty, Dunst, i3, Neovim, Polybar, Rofi, Tmux, and Redshift.

## Theme

All components use the **Catppuccin** color scheme (Mocha variant by default). Color variables are defined in each config file. When modifying colors, keep them consistent across components.

## Neovim Configuration

Structure:
- `nvim/init.lua` - Entry point that loads modules
- `nvim/lua/settings.lua` - Editor settings
- `nvim/lua/keymaps.lua` - All keybindings (uses which-key)
- `nvim/lua/lsp.lua` - LSP configuration
- `nvim/lua/plugins/*.lua` - Individual plugin configs (one file per plugin)

Plugin management: Uses **Lazy.nvim**. After adding/modifying plugins, open nvim and run `:Lazy` then press `I` to install. Plugin data lives in `~/.local/share/nvim/`.

Key leader: `<Space>`. Important mappings include `<leader>s` for search (Telescope), `<leader>l` for LSP actions, `<leader>g` for git, `<leader>z` for Zk notes.

## i3 Window Manager

- Mod key: `$mod` = Super/Windows key
- Navigation: vim-style with hjkl
- Rofi launcher: `$mod+d`
- Gaps: 20px inner gaps
- Starts polybar, redshift, and sets touchpad/mouse settings on startup

## Tmux

Uses **TPM** (Tmux Plugin Manager). Plugins auto-install from `~/.tmux/plugins/` (gitignored). Prefix key is default `Ctrl+b`. Uses vi mode for copy operations.

## Git Structure

The `.gitignore` uses an inverted pattern: everything is ignored by default (`/*`) except explicitly allowed directories. To track a new config directory, add `!dirname/` to `.gitignore`.
