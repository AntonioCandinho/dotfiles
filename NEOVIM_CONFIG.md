# Neovim Configuration Documentation

## Configuration Requirements

### Language Support Matrix

| Language   | Code Completion | Formatting  | Highlighting | LSP Server           |
| ---------- | --------------- | ----------- | ------------ | -------------------- |
| Swift      | ✅ Required     | ✅ Required | ✅ Required  | sourcekit-lsp        |
| JavaScript | ✅ Required     | ✅ Required | ✅ Required  | vtsls                |
| TypeScript | ✅ Required     | ✅ Required | ✅ Required  | vtsls                |
| HTML       | ✅ Required     | ✅ Required | ✅ Required  | html-language-server |
| CSS/SCSS   | ✅ Required     | ✅ Required | ✅ Required  | css-language-server  |
| React      | ✅ Required     | ✅ Required | ✅ Required  | vtsls                |
| Vue        | ✅ Required     | ✅ Required | ✅ Required  | vue-language-server  |
| Zig        | ✅ Required     | ✅ Required | ✅ Required  | zls                  |
| Rust       | ✅ Required     | ✅ Required | ✅ Required  | rust-analyzer        |
| C          | ✅ Required     | ✅ Required | ✅ Required  | clangd               |
| C++        | ✅ Required     | ✅ Required | ✅ Required  | clangd               |
| Lua        | ✅ Required     | ✅ Required | ✅ Required  | lua-language-server  |

### Core Features

- **No AI tooling by default**: Avoid background AI agents/completions for stability and performance
- **Minimal Configuration**: Keep plugin count and complexity low
- **Lua-based**: All configuration written in Lua
- **Plugin Manager**: Using lazy.nvim for plugin management
- **Native LSP**: Neovim v0.11+ native LSP support (no nvim-lspconfig dependency)
- **Server Management**: mason.nvim for managing LSP server installation

### Current Structure

```
nvim/
├── init.lua              # Main configuration entry point
├── lazy-lock.json        # Plugin version lock file
├── lua/
│   ├── config/           # Core configuration modules
│   │   ├── settings.lua  # Core Neovim settings
│   │   ├── lsp.lua       # Native LSP loader/manager
│   │   ├── keymaps.lua   # Global keybindings
│   │   └── autocmds.lua  # Autocommands and events
│   ├── lazy-setup.lua    # Lazy.nvim setup with { import = "plugins" }
│   └── plugins/          # Individual plugin specifications (lazy.nvim standard)
│       ├── blink-cmp.lua # Completion engine
│       └── ...           # Other plugin files
├── lsp/                  # Individual LSP server configs (auto-discovered)
│   ├── lua_ls.lua        # Lua language server
│   ├── vtsls.lua         # TypeScript language server
│   └── ...               # Other server configs
├── lazy-lock.json        # Plugin version lock file
└── plugin/               # Plugin directory
```

## Essential Plugin Categories

1. **LSP & Completion**

   - **Native LSP**: Neovim v0.11+ built-in LSP support
   - **blink.cmp**: Modern completion engine
   - **mason.nvim**: LSP server management and installation

2. **Syntax & Highlighting**

   - nvim-treesitter (advanced syntax highlighting)

3. **Formatting**

   - **formatter.nvim**: Code formatting across languages

4. **File Navigation**

   - **telescope.nvim**: Fuzzy finder and file navigation
   - **telescope-fzf-native**: Native fuzzy matching

## External Documentation Links

### Official Neovim Documentation

- **Latest Neovim Help**: `:help` command in Neovim or https://neovim.io/doc/user/
- **Neovim User Manual**: https://neovim.io/doc/user/usr_toc.html
- **Neovim LSP Guide**: https://neovim.io/doc/user/lsp.html
- **Lua Guide for Neovim**: https://neovim.io/doc/user/lua-guide.html

### Plugin Documentation

- **lazy.nvim**: https://github.com/folke/lazy.nvim
- **blink.cmp**: https://github.com/saghen/blink.cmp
- **mason.nvim**: https://github.com/williamboman/mason.nvim
- **nvim-treesitter**: https://github.com/nvim-treesitter/nvim-treesitter
- **formatter.nvim**: https://github.com/mhartington/formatter.nvim
- **telescope.nvim**: https://github.com/nvim-telescope/telescope.nvim

### Language Server Documentation

- **LSP Server List**: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
- **Swift LSP (sourcekit-lsp)**: https://github.com/apple/sourcekit-lsp
- **Rust Analyzer**: https://rust-analyzer.github.io/
- **Zig LSP (zls)**: https://github.com/zigtools/zls

## Configuration Principles

- **Performance First**: Optimize for startup time and responsiveness
- **Native First**: Use Neovim's built-in capabilities before external plugins
- **Lazy.nvim Standard**: Follow lazy.nvim conventions with individual plugin files
- **Auto-Discovery**: Leverage automatic discovery for both plugins and LSP servers
- **Consistency**: Uniform behavior across all supported languages
- **Extensibility**: Easy to add new languages or plugins by creating files
- **Standard Structure**: Follow conventional Neovim configuration organization
- **Documentation**: Well-commented configuration for maintainability
- **Automatic Management**: Use mason.nvim for seamless LSP server installation
