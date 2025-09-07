# Dotfiles Project Overview

## Project Description

This repository contains personal configuration files (dotfiles) for development tools and environments. The primary focus is on creating a minimal yet powerful development setup optimized for multiple programming languages.

## Project Structure

```
dotfiles/
├── nvim/                 # Neovim configuration (primary focus)
├── lsp-servers/         # Language Server Protocol servers
├── tmux/                # Terminal multiplexer configuration
├── scripts/             # Utility scripts
└── README.md           # Project documentation
```

## Core Philosophy

- **Minimalism**: Keep configurations lean and focused
- **Multi-language Support**: Seamless development across various programming languages
- **Modern Tooling**: Leverage contemporary development tools and practices
- **Maintainability**: Easy to update and customize

## Supported Development Languages

- Swift
- JavaScript
- TypeScript
- HTML
- React
- Vue
- Zig
- Rust
- C
- C++

## Key Features Required

- Code completion across all languages
- Consistent formatting
- Syntax highlighting
- AI-powered code completion
- Language Server Protocol (LSP) integration

## LSP Servers Available

The project includes several pre-configured LSP servers:

- `lua-language-server/` - Lua language support
- `rust-analyzer/` - Rust language support
- `zls/` - Zig language support
- Additional servers available via npm

## Configuration Management

- Neovim: Lua-based configuration with lazy.nvim plugin manager
- Modular structure for easy maintenance and updates
