# Pedro's ZSH Configuration

A well-organized, feature-rich ZSH configuration for macOS with Emacs keybindings, modern plugins, and sensible defaults.

## Features

### Core Configuration
- **Emacs as default editor** - Both `$EDITOR` and `$VISUAL` set to emacs
- **UTF-8 encoding** - Proper locale settings for international text
- **XDG Base Directory** - Follows the XDG specification for config, data, and cache

### History
- 50,000 lines of history retained
- Shared between all sessions
- Timestamps recorded
- Duplicate handling and space-prefixed command filtering

### Directory Navigation
- `AUTO_CD` - Type directory names to cd into them
- `AUTO_PUSHD` - Automatic directory stack
- Named directories: `~projects`, `~config`, `~downloads`

### Completion System
- Arrow-key menu selection
- Case-insensitive matching
- Colored completions using `LS_COLORS`
- Grouped by category with styled descriptions

### Emacs Keybindings
Full Emacs-style navigation and editing:

| Key | Action |
|-----|--------|
| `Ctrl+A/E` | Beginning/end of line |
| `Ctrl+F/B` | Forward/backward char |
| `Alt+F/B` | Forward/backward word |
| `Ctrl+K/U` | Kill to end/start of line |
| `Ctrl+W` | Kill word/region |
| `Ctrl+Y` | Yank (paste) |
| `Ctrl+R` | Reverse history search |
| `Ctrl+Space` | Set mark |
| `Ctrl+X h` | Select entire line |

### Plugins (via Zinit)
Zinit auto-installs on first run. Included plugins:

- **zsh-syntax-highlighting** - Fish-like syntax highlighting
- **zsh-autosuggestions** - Fish-like autosuggestions (accept with `Shift+Tab`)
- **zsh-history-substring-search** - Better history search with arrow keys
- **zsh-completions** - Additional completion definitions
- **zsh-z** - Fast directory jumping (`z` command)
- **pure** - Minimal, fast prompt with git status

### Aliases

**Navigation:**
```
..    ...    ....    ~    -
```

**Files:**
```
ls    ll    la    l    lt    lz
```

**Safety nets:**
```
rm -i    cp -i    mv -i    mkdir -pv
```

**Git:**
```
g    gs    ga    gc    gp    gl    gd    gco    gb    glog
```

**Emacs:**
```
e    ec    et
```

**Utilities:**
```
c (clear)    h (history)    path    reload    zshrc
```

### Functions

| Function | Description |
|----------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `extract <file>` | Extract any archive format |
| `f <pattern>` | Quick find in current directory |
| `gr <pattern>` | Grep recursively with context |
| `dirsize [dir]` | Show directory size |
| `weather [city]` | Weather in terminal |

### Version Managers
- **NVM** - Node.js version management (via Homebrew)
- **pyenv** - Python version management

### PATH Configuration
- Homebrew on Apple Silicon (`/opt/homebrew/bin`)
- Local binaries (`~/.local/bin`)
- Emacs Plus binaries
- Automatic duplicate removal

## Installation

1. **Clone the repository:**
   ```bash
   git clone git@github.com:YOUR_USERNAME/zshrc.git ~/projects/zshrc
   ```

2. **Symlink the configuration:**
   ```bash
   ln -sf ~/projects/zshrc/.zshrc ~/.zshrc
   ```

3. **Set up secrets (optional):**
   ```bash
   cp ~/projects/zshrc/.secure_env_vars.example ~/.secure_env_vars
   # Edit ~/.secure_env_vars with your actual values
   ```

4. **Reload your shell:**
   ```bash
   source ~/.zshrc
   ```

Zinit and plugins will auto-install on first load.

## Secret Management

Environment variables containing API keys and credentials are stored separately:

- `.secure_env_vars.example` - Template with placeholder values (committed)
- `~/.secure_env_vars` - Actual secrets (gitignored, lives in home directory)

This keeps sensitive data out of version control while providing a template for required variables.

## Requirements

- macOS (some features are macOS-specific)
- Git (for Zinit installation)
- [Homebrew](https://brew.sh/) (recommended)

## Customization

Edit `~/.zshrc` or the symlinked file directly. After making changes:

```bash
reload  # or: source ~/.zshrc
```

## License

Personal configuration - use freely.
