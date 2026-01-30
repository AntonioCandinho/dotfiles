---
name: dotfiles
description: Operational context for working on Antonio's dotfiles repo (Neovim, Kitty, tmux) with OpenCode.
---

# Project Context

This repository contains personal dotfiles and development environment configuration.

Primary focus:
- Neovim configuration (Lua-based)
- Fast, minimal, multi-language developer experience

Secondary:
- Kitty terminal configuration
- tmux configuration (may be legacy/optional depending on current setup)

# Non-Negotiable Rules

- Lua only for Neovim configuration.
- Multi-language support must remain intact: Swift, JavaScript, TypeScript, HTML, CSS, React, Vue, Zig, Rust, C, C++.
- No AI tooling by default inside Neovim (no background AI agents/completions) to preserve stability and performance.
- Prefer small, maintainable changes; avoid over-configuring.

# Repository Structure

Key paths:

- `nvim/`: Neovim configuration (primary)
- `kitty/`: Kitty configuration
- `tmux/`: tmux configuration
- `skills/`: OpenCode agent skills (visible)

OpenCode discovery:
- This repo does not commit `.opencode/`.
- If you want OpenCode to auto-discover skills from this repo, create a local symlink:
  - `.opencode/skills -> ../skills`

OpenCode skills:
- Skills live at `skills/<skill-name>/SKILL.md`.
- OpenCode expects `.opencode/skills/<skill-name>/SKILL.md`.

# Neovim Architecture Notes

This setup uses Neovim v0.11+ native LSP support (no `nvim-lspconfig` dependency).

Relevant directories:
- `nvim/lua/config/`: core modules (settings, keymaps, lsp loader, autocmds)
- `nvim/lua/plugins/`: lazy.nvim plugin specs (one file per plugin)
- `nvim/lsp/`: language server configs (auto-discovered)

Common checks:
- LSP status: `:LspInfo`
- Plugin status: `:Lazy`
- Mason: `:Mason`
- Health: `:checkhealth`

# How To Work In This Repo (Guidance)

When making changes:
- Prefer editing existing files over adding new ones.
- Keep config lean: avoid adding plugins unless they clearly replace multiple existing behaviors or fix a concrete issue.
- If a change affects startup time or responsiveness, call it out.

When adding support for a new language:
- Add an LSP config under `nvim/lsp/<server>.lua`.
- Ensure completion, formatting, and highlighting remain consistent with existing languages.

# OpenCode Skills Available

- `swift-performance`: Write and review Swift code with performance, memory, and concurrency correctness in mind.
