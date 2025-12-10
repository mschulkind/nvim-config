# Library Modules

This directory contains shared library modules used across the Neovim configuration.

## Structure

- `plugin_manager_lzn.lua` - Plugin manager using lz.n for lazy-loading and vim.pack for installation

## Usage

The plugin manager auto-discovers all `.lua` files in `lua/plugins/` and handles installation and lazy-loading automatically.