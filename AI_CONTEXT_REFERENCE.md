# AI Assistant Context Reference

> **Quick Reference**: This file provides essential context for AI assistants working with this dotfiles project.

## Project Summary

**Type**: Personal dotfiles configuration  
**Primary Focus**: Neovim configuration for multi-language development  
**Philosophy**: Minimal, performant, modern development environment

## User Requirements (Critical)

- **Configuration Language**: Lua only
- **Supported Languages**: Swift, JavaScript, TypeScript, HTML, CSS, React, Vue, Zig, Rust, C, C++
- **Required Features**: Code completion, formatting, highlighting for ALL languages
- **No AI tooling by default**: Avoid background AI agents/completions for stability and performance
- **Minimalism**: Keep configuration lean and focused

## Current State Quick Facts

- ✅ **Plugin Manager**: lazy.nvim (configured)
- ✅ **LSP**: Native Neovim v0.11+ LSP (language-specific configs in `nvim/lsp/`)
- ✅ **Completion**: blink.cmp (+ LSP, buffer, path, etc.)
- ✅ **Highlighting**: nvim-treesitter
- ✅ **Formatting**: formatter.nvim
- ✅ **Server Management**: mason.nvim for managing installations
- ✅ **Structure**: Standard config/ directory organization

## Key File Locations

```
/Users/antonio/Projects/dotfiles/
├── nvim/init.lua                          # Main entry point
├── nvim/lua/config/                       # Core configuration modules
│   ├── settings.lua                      # Core vim settings (moved from lua/)
│   ├── lsp.lua                           # LSP loader/manager
│   └── autocmds.lua                      # Autocommands, keymaps & LSP initialization
├── nvim/lsp/                              # Individual LSP server configs (auto-discovered)
│   ├── lua_ls.lua                        # Lua language server
│   ├── vtsls.lua                         # TypeScript language server
│   ├── sourcekit.lua                     # Swift language server
│   └── ...                               # Other server configs
├── nvim/lua/
│   ├── lazy-setup.lua                    # Lazy.nvim setup with import spec
│   └── plugins/                          # Individual plugin specifications (lazy.nvim standard)
│       ├── blink-cmp.lua                 # Completion engine
│       ├── gruvbox.lua                   # Color theme
│       ├── mason.lua                     # LSP server manager
│       └── ...                           # Other individual plugin files
├── nvim/lazy-lock.json                   # Plugin version lock file
├── lsp-servers/                          # Available LSP servers
└── [PROJECT_DOCS]                        # AI context files
```

## LSP Server Status Matrix (Native Configuration)

| Language   | Server        | Status        | Installation      |
| ---------- | ------------- | ------------- | ----------------- |
| Swift      | sourcekit     | ✅ Configured | System/Xcode      |
| JavaScript | vtsls         | ✅ Configured | mason.nvim        |
| TypeScript | vtsls         | ✅ Configured | mason.nvim        |
| HTML       | html          | ✅ Configured | mason.nvim        |
| React      | vtsls         | ✅ Configured | mason.nvim        |
| Vue        | volar         | ✅ Configured | mason.nvim        |
| Zig        | zls           | ✅ Configured | mason.nvim/local  |
| Rust       | rust_analyzer | ✅ Configured | mason.nvim/local  |
| C/C++      | clangd        | ✅ Configured | System/mason.nvim |
| Bash       | bashls        | ✅ Configured | mason.nvim        |
| Lua        | lua_ls        | ✅ Configured | mason.nvim/local  |

## Common Tasks & Hints

- **Add LSP Server**: Create `nvim/lsp/server_name.lua` (automatically discovered by Neovim)
- **Modify LSP Server**: Edit individual file in `nvim/lsp/server_name.lua`
- **Add Plugin**: Create `nvim/lua/plugins/plugin-name.lua` (automatically imported by lazy.nvim)
- **Plugin Changes**: Use `:Lazy` command to manage
- **Install Servers**: Use `:Mason` command or automatic mason.nvim installation
- **Check LSP**: Use `:LspInfo` and `:checkhealth`
- **New Language**: Create `lsp/server_name.lua` (auto-discovered) + treesitter parser + formatter
- **Performance**: Configuration prioritizes lazy loading and startup speed
- **Native LSP**: Uses Neovim v0.11+ `vim.lsp.config()` and `vim.lsp.enable()`
- **Auto-Discovery**: Neovim automatically discovers LSP configs from `lsp/` directory
- **Lazy.nvim Standard**: Uses `{ import = "plugins" }` pattern for automatic plugin discovery
- **Modular Structure**: Each LSP server and plugin has its own config file for maintainability

## Documentation Links

- **Neovim**: https://neovim.io/doc/user/
- **lazy.nvim**: https://github.com/folke/lazy.nvim
- **LSP Configs**: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
- **Treesitter**: https://github.com/nvim-treesitter/nvim-treesitter

## User Preferences

- Prefers editing existing files over creating new ones
- Values performance and minimalism
- Uses space as leader key
- Prefers lua-based configuration
- Wants comprehensive language support
- Uses ripgrep for search when available

---

_This reference is designed to be read by AI assistants to quickly understand the project context and current state._
