# zshrc

![The Birth of Venus](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg/960px-Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg)

*"The Birth of Venus" (c. 1485) by Sandro Botticelli — [Wikipedia](https://en.wikipedia.org/wiki/The_Birth_of_Venus)*

**A keyboard-first ZSH configuration for macOS -- Emacs keybindings, Zinit plugins, and system clipboard integration.**

## About

A well-organized ZSH configuration built around the philosophy that your shell should feel like Emacs. Every kill and yank operation syncs with the macOS system clipboard, Zinit handles plugin management with lazy loading, and sensible defaults make the terminal pleasant to work in from the first launch.

## Key Highlights

- **Emacs keybindings with clipboard sync** -- `Ctrl+K`, `Ctrl+W`, `Alt+D` all pipe through `pbcopy`; `Ctrl+Y` yanks from `pbpaste`
- **Zinit plugin manager** -- auto-installs on first run with Fish-like syntax highlighting, autosuggestions, and history substring search
- **Powerlevel10k prompt** -- fast, informative prompt with git status
- **50,000-line shared history** -- with timestamps, deduplication, and cross-session sync
- **Named directories** -- `~projects`, `~config`, `~downloads` for quick navigation

## Features

### Emacs Keybindings

Full Emacs-style navigation and editing:

| Key | Action |
|-----|--------|
| `Ctrl+A/E` | Beginning/end of line |
| `Ctrl+F/B` | Forward/backward char |
| `Alt+F/B` | Forward/backward word |
| `Ctrl+K/U` | Kill to end/start of line (syncs to system clipboard) |
| `Ctrl+W` | Kill word/region (syncs to system clipboard) |
| `Alt+D` | Kill word after cursor (syncs to system clipboard) |
| `Alt+W` | Copy region (syncs to system clipboard) |
| `Ctrl+Y` | Yank from system clipboard |
| `Ctrl+R` | Reverse history search |
| `Ctrl+Space` | Set mark |
| `Ctrl+X h` | Select entire line |

### Plugins (via Zinit)

Zinit auto-installs on first run. Included plugins:

- **zsh-syntax-highlighting** -- Fish-like syntax highlighting
- **zsh-autosuggestions** -- Fish-like autosuggestions (accept with `Shift+Tab`)
- **zsh-history-substring-search** -- Better history search with arrow keys
- **zsh-completions** -- Additional completion definitions
- **zsh-z** -- Fast directory jumping (`z` command)
- **Powerlevel10k** -- Feature-rich prompt with git status

### Aliases

**Navigation:** `..`, `...`, `....`, `~`, `-`

**Files (using eza):** `ls`, `ll`, `la`, `l`, `lt`, `lz`

**Safety nets:** `rm -i`, `cp -i`, `mv -i`, `mkdir -pv`

**Git:** `g`, `gs`, `ga`, `gc`, `gp`, `gl`, `gd`, `gco`, `gb`, `glog`

**Emacs:** `e`, `ec`, `et`

**Utilities:** `c` (clear), `h` (history), `path`, `reload`, `zshrc`

### Utility Functions

| Function | Description |
|----------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `extract <file>` | Extract any archive format |
| `f <pattern>` | Quick find in current directory |
| `gr <pattern>` | Grep recursively with context |
| `dirsize [dir]` | Show directory size |
| `weather [city]` | Weather in terminal |

### Version Managers

- **NVM** -- Node.js version management (via Homebrew)
- **pyenv** -- Python version management

## Installation

1. **Clone the repository:**
   ```bash
   git clone git@github.com:pdelfino/zshrc.git ~/projects/zshrc
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

- `.secure_env_vars.example` -- Template with placeholder values (committed)
- `~/.secure_env_vars` -- Actual secrets (gitignored, lives in home directory)

This keeps sensitive data out of version control while providing a template for required variables. The `CLAUDE_SLACK_WEBHOOK_URL` variable is used by [claude-config](https://github.com/pdelfino/claude-config) hooks to send Slack notifications when Claude Code is waiting for input.

## Requirements

- macOS (some features are macOS-specific, e.g., `pbcopy`/`pbpaste` integration)
- Git (for Zinit installation)
- [Homebrew](https://brew.sh/) (recommended)

## Related

- [emacs-config](https://github.com/pdelfino/emacs-config) -- Emacs setup with Ivy, Projectile, Paredit, and Claude Code
- [karabiner-config](https://github.com/pdelfino/karabiner-config) -- Emacs keybindings system-wide on macOS
- [homerow-config](https://github.com/pdelfino/homerow-config) -- Click things without a mouse
- [iterm2-config](https://github.com/pdelfino/iterm2-config) -- iTerm2 profile with copy-on-selection
- [claude-config](https://github.com/pdelfino/claude-config) -- Claude Code configuration with Emacs-style keybindings
- [macos-setup](https://github.com/pdelfino/macos-setup) -- The bootstrap that ties it all together

## License

Personal configuration -- use freely.
