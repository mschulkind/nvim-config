# Library Modules

This directory contains shared library modules used across the Neovim configuration.

## Structure

- `plugin_manager/` - Plugin management system for loading and configuring plugins
  - `plugin_manager.lua` - Main plugin manager with auto-discovery and installation
  - `auto_loader.lua` - Automatic plugin file discovery and loading

## Usage

These modules are used internally by the plugin system and should not be called directly from user configurations.