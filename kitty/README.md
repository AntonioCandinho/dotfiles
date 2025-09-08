# Kitty Configuration - Complete tmux Replacement

This configuration replaces both ghostty and tmux with Kitty's native window management features. Kitty provides excellent built-in splitting, tabs, and session management that eliminates the need for a terminal multiplexer.

## Why Kitty Over ghostty + tmux?

### **Native Integration**
- **Better Performance**: No multiplexer overhead - everything is native
- **Seamless Experience**: No switching between terminal and multiplexer contexts
- **Modern Features**: GPU acceleration, ligatures, and advanced rendering
- **Session Persistence**: Built-in session saving and restoration

### **Superior Window Management**
- **Native Splits**: Faster and more responsive than tmux panes
- **Flexible Layouts**: Dynamic resizing and layout management
- **Tab Management**: Better tab handling than tmux windows
- **Keyboard Driven**: Vim-style navigation built-in

## Installation & Setup

1. **Install Kitty**: `brew install kitty` (macOS)
2. **Configuration Files**: 
   - Main config: `~/.config/kitty/kitty.conf` (symlinked from dotfiles)
   - Theme: `~/.config/kitty/kanagawa-wave.conf` (symlinked from dotfiles)
   - Session: `~/.config/kitty/session.conf` (symlinked from dotfiles)

3. **Setup Symlinks**:
   ```bash
   mkdir -p ~/.config/kitty
   ln -sf /path/to/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
   ln -sf /path/to/dotfiles/kitty/kanagawa-wave.conf ~/.config/kitty/kanagawa-wave.conf
   ln -sf /path/to/dotfiles/kitty/session.conf ~/.config/kitty/session.conf
   ```

## Theme: Kanagawa Wave

Beautiful theme inspired by Katsushika Hokusai's famous painting "The Great Wave off Kanagawa". Based on [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) with the "wave" variant.

### **Color Palette**
- **Background**: Deep indigo (`#1F1F28`) - like the night sky
- **Foreground**: Warm white (`#DCD7BA`) - like moonlight on waves
- **Accents**: Blues, teals, and warm colors inspired by the painting
- **Perfect Contrast**: WCAG 2.1 compliant with 4.5:1 contrast ratio

## Key Mappings (tmux → Kitty equivalent)

### **Core Functionality**

| tmux Command   | Kitty Equivalent   | Description                                   |
| -------------- | ------------------ | --------------------------------------------- |
| `Ctrl-s + v`   | `Ctrl-s + v`       | Split vertically (create pane to the right)  |
| `Ctrl-s + s`   | `Ctrl-s + s`       | Split horizontally (create pane below)       |
| `Ctrl-s + h`   | `Ctrl-s + h`       | Move to left pane                             |
| `Ctrl-s + j`   | `Ctrl-s + j`       | Move to bottom pane                           |
| `Ctrl-s + k`   | `Ctrl-s + k`       | Move to top pane                              |
| `Ctrl-s + l`   | `Ctrl-s + l`       | Move to right pane                            |
| `Ctrl-s + x`   | `Ctrl-s + x`       | Close current pane                            |
| `Ctrl-s + z`   | `Ctrl-s + z`       | Toggle pane zoom                              |
| `Ctrl-s + r`   | `Ctrl-s + r`       | Reload configuration                          |

### **Tab Management**

| tmux Command   | Kitty Equivalent   | Description         |
| -------------- | ------------------ | ------------------- |
| `Ctrl-s + c`   | `Ctrl-s + c`       | Create new tab      |
| `Ctrl-s + n`   | `Ctrl-s + n`       | Next tab            |
| `Ctrl-s + p`   | `Ctrl-s + p`       | Previous tab        |

### **Window Resizing**

| Command              | Description                    |
| -------------------- | ------------------------------ |
| `Ctrl-s + Shift-h`   | Resize window narrower         |
| `Ctrl-s + Shift-j`   | Resize window shorter          |
| `Ctrl-s + Shift-k`   | Resize window taller           |
| `Ctrl-s + Shift-l`   | Resize window wider            |

### **Quick Access (No Prefix)**

| Command        | Description                            |
| -------------- | -------------------------------------- |
| `Cmd-d`        | Quick vertical split                   |
| `Cmd-Shift-d`  | Quick horizontal split                 |
| `Cmd-w`        | Quick close window                     |
| `Cmd-t`        | Quick new tab                          |
| `Cmd-1` to `5` | Jump to tab 1-5                       |

### **Session Management**

| Command              | Description                    |
| -------------------- | ------------------------------ |
| `Ctrl-s + Shift-s`   | Save current session           |
| `Ctrl-s + Shift-r`   | Restore saved session          |

## Advanced Features

### **Layout Management**
- **Stack Layout**: `Ctrl-s + z` toggles focus mode (like tmux zoom)
- **Dynamic Resizing**: Resize any window with mouse or keyboard
- **Layout Persistence**: Sessions remember window arrangements

### **Shell Integration**
- **Automatic Updates**: Window titles update based on running commands
- **Smart Navigation**: Knows about vim splits and integrates seamlessly
- **Remote Control**: Scriptable via `kitty @` commands

### **Performance Features**
- **GPU Acceleration**: Smooth scrolling and rendering
- **Efficient Memory**: Better memory usage than multiplexer solutions
- **Fast Startup**: No multiplexer initialization delay

## Session Management

Unlike tmux sessions that persist across restarts, Kitty sessions are saved/restored manually:

```bash
# Save current layout to default session
kitty @ save-session ~/.config/kitty/default-session.conf

# Restore from saved session
kitty --session ~/.config/kitty/default-session.conf
```

### **Auto-Session on Startup**
The configuration includes `startup_session session.conf` which creates a default layout when Kitty starts.

## Comparison with tmux

### **Advantages Over tmux**

| Feature | Kitty | tmux |
|---------|--------|------|
| **Performance** | Native, no overhead | Multiplexer overhead |
| **GPU Acceleration** | ✅ Full support | ❌ Not applicable |
| **Font Rendering** | ✅ Excellent | ⚠️ Basic |
| **Mouse Support** | ✅ Native, seamless | ⚠️ Requires config |
| **Clipboard** | ✅ Native integration | ⚠️ Requires setup |
| **Session Startup** | ✅ Instant | ⚠️ Initialization delay |

### **What You Gain**
- **Modern UX**: Better visual feedback and interaction
- **Scriptability**: Rich API for automation via `kitty @` commands
- **Extensibility**: Kitten plugins for additional functionality
- **Integration**: Better OS integration (notifications, clipboard, etc.)

### **What You Lose vs tmux**
- **Remote Sessions**: Can't detach/reattach from remote servers
- **Auto-Persistence**: Sessions don't automatically survive crashes
- **Server Model**: No background daemon keeping sessions alive

## Migration Tips

### **From tmux Workflow**
1. **Start with familiar keybindings**: All your `Ctrl-s` bindings work the same
2. **Use sessions for projects**: Create different session files for different projects
3. **Script common layouts**: Use `kitty @` commands to automate setup

### **Best Practices**
- **One Kitty per project**: Use separate Kitty instances for different work
- **Save important sessions**: Regularly save layouts you want to preserve
- **Use quick bindings**: Take advantage of `Cmd+` shortcuts for speed

## Configuration Files

### **kitty.conf**
Main configuration with keybindings, settings, and theme inclusion.

### **kanagawa-wave.conf**
Complete Kanagawa color scheme with all ANSI colors, UI colors, and accessibility-compliant contrast ratios.

### **session.conf**
Default startup session that creates a basic layout.

## Troubleshooting

### **Theme Not Loading**
- Ensure `kanagawa-wave.conf` is in the same directory as `kitty.conf`
- Check file permissions on theme file
- Restart Kitty after theme changes

### **Keybindings Not Working**
- Verify `clear_all_shortcuts yes` is in config (removes conflicts)
- Check that `kitty.conf` is being loaded from the correct location
- Use `Ctrl-s + r` to reload configuration

### **Performance Issues**
- Ensure GPU acceleration is enabled (should be automatic)
- Check `sync_to_monitor yes` is set for smooth rendering
- Reduce `repaint_delay` if experiencing lag

## Development Workflow

### **Perfect for Local Development**
- **Fast splits**: Instant terminal multiplexing for local work
- **Rich theming**: Beautiful, consistent visual environment
- **Project sessions**: Different saved layouts for different projects
- **Integration**: Works seamlessly with macOS features

### **For Remote Work**
For remote development, you might still want tmux on the server side:
- **Local Kitty**: For beautiful local terminal experience
- **Remote tmux**: For server-side session persistence
- **Best of both**: Modern local terminal + robust remote multiplexing

Perfect combination of modern terminal features with powerful window management! 🌊
