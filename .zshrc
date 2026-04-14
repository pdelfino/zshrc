# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                                                                              ║
# ║                            Pedro's ZSH Configuration                         ║
# ║                                                                              ║
# ╚══════════════════════════════════════════════════════════════════════════════╝


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                              Core Settings                                   │
# └──────────────────────────────────────────────────────────────────────────────┘

export EDITOR="emacs"
export VISUAL="emacs"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                              History Settings                                │
# └──────────────────────────────────────────────────────────────────────────────┘

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000                   # How many lines kept in memory
SAVEHIST=50000                   # How many lines saved to disk

setopt EXTENDED_HISTORY          # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first when trimming
setopt HIST_FIND_NO_DUPS         # Don't show duplicates when searching
setopt HIST_IGNORE_DUPS          # Don't record consecutive duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_VERIFY               # Show command before executing from history
setopt SHARE_HISTORY             # Share history between all sessions
setopt INC_APPEND_HISTORY        # Write to history immediately


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                            Directory Options                                 │
# └──────────────────────────────────────────────────────────────────────────────┘

setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # Push directories onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates
setopt PUSHD_SILENT              # Don't print stack after pushd/popd

# Quick directory access (use ~projects, ~config, etc.)
hash -d projects="$HOME/Projects"
hash -d config="$HOME/.config"
hash -d downloads="$HOME/Downloads"


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                            Completion System                                 │
# └──────────────────────────────────────────────────────────────────────────────┘

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

zstyle ':completion:*' menu select                       # Arrow key menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Colored completions
zstyle ':completion:*' group-name ''                     # Group by category
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'
zstyle ':completion:*:warnings' format '%F{red}No matches%f'


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                             Emacs Keybindings                                │
# └──────────────────────────────────────────────────────────────────────────────┘

bindkey -e                       # Emacs mode

# Navigation
bindkey '^A' beginning-of-line   # Ctrl+A: Start of line
bindkey '^E' end-of-line         # Ctrl+E: End of line
bindkey '^F' forward-char        # Ctrl+F: Forward one char
bindkey '^B' backward-char       # Ctrl+B: Back one char
bindkey '^[f' forward-word       # Alt+F:  Forward one word
bindkey '^[b' backward-word      # Alt+B:  Back one word

# Sync kill ring to system clipboard (pbcopy)
function _sync-cutbuffer-to-clipboard {
    [[ -n "$CUTBUFFER" ]] && print -rn -- "$CUTBUFFER" | pbcopy
}
function kill-line-to-clipboard           { zle kill-line;           _sync-cutbuffer-to-clipboard }
function backward-kill-line-to-clipboard  { zle backward-kill-line;  _sync-cutbuffer-to-clipboard }
function kill-region-to-clipboard         { zle kill-region;         _sync-cutbuffer-to-clipboard }
function backward-kill-word-to-clipboard  { zle backward-kill-word;  _sync-cutbuffer-to-clipboard }
function kill-word-to-clipboard           { zle kill-word;           _sync-cutbuffer-to-clipboard }
function copy-region-as-kill-to-clipboard { zle copy-region-as-kill; _sync-cutbuffer-to-clipboard }
function yank-from-clipboard { CUTBUFFER=$(pbpaste); zle yank }
zle -N yank-from-clipboard
zle -N kill-line-to-clipboard
zle -N backward-kill-line-to-clipboard
zle -N kill-region-to-clipboard
zle -N backward-kill-word-to-clipboard
zle -N kill-word-to-clipboard
zle -N copy-region-as-kill-to-clipboard

# Editing
bindkey '^D' delete-char         # Ctrl+D: Delete char under cursor
bindkey '^H' backward-delete-char # Ctrl+H: Delete char before cursor
bindkey '^K' kill-line-to-clipboard          # Ctrl+K: Kill to end of line
bindkey '^U' backward-kill-line-to-clipboard # Ctrl+U: Kill to start of line
bindkey '^W' backward-kill-word-to-clipboard # Ctrl+W: Kill word before cursor
bindkey '^[d' kill-word-to-clipboard         # Alt+D:  Kill word after cursor
bindkey '^Y' yank-from-clipboard # Ctrl+Y: Yank from system clipboard

# History search (type partial command, then use arrows)
bindkey '^P' up-line-or-search   # Ctrl+P: Previous in history
bindkey '^N' down-line-or-search # Ctrl+N: Next in history
bindkey '^R' history-incremental-search-backward  # Ctrl+R: Search history

# Select all (mark whole line) - Emacs style C-x h
select-all() {
    zle beginning-of-line
    zle set-mark-command
    zle end-of-line
}
zle -N select-all
bindkey '^Xh' select-all         # Ctrl+X h: Select entire line

# Region operations (Emacs style)
bindkey '^[w' copy-region-as-kill-to-clipboard # Alt+W: Copy region
bindkey '^W' kill-region-to-clipboard          # Ctrl+W: Cut region
bindkey '^@' set-mark-command     # Ctrl+Space: Set mark


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                           Plugin Manager (Zinit)                             │
# └──────────────────────────────────────────────────────────────────────────────┘

# Auto-install zinit if not present
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{blue}Installing zinit...%f"
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ─── Essential Plugins ────────────────────────────────────────────────────────

# Syntax highlighting (must be loaded before autosuggestions)
zinit light zsh-users/zsh-syntax-highlighting

# Fish-like autosuggestions
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"
bindkey '^[[Z' autosuggest-accept  # Shift+Tab to accept suggestion

# Better history search
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow

# Additional completions
zinit light zsh-users/zsh-completions

# ─── Useful Extras ────────────────────────────────────────────────────────────

# Fast directory jumping (z command)
zinit light agkozak/zsh-z
ZSHZ_DATA="$XDG_DATA_HOME/z/.z"

# Powerlevel10k prompt (run `p10k configure` to customize)
zinit ice depth=1
zinit light romkatv/powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                                 Aliases                                      │
# └──────────────────────────────────────────────────────────────────────────────┘

# ─── Navigation ───────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"                # Go to previous directory

# ─── List Files (eza with icons, fallback to ls) ────────────────────────────
if command -v eza &>/dev/null; then
    alias ls="eza --icons"
    alias ll="eza -la --icons --git"
    alias la="eza -a --icons"
    alias l="eza --icons"
    alias lt="eza -la --icons --sort=modified"
    alias lz="eza -la --icons --sort=size"
    alias tree="eza --tree --icons"
else
    alias ls="ls -G"
    alias ll="ls -lAh"
    alias la="ls -A"
    alias l="ls -CF"
    alias lt="ls -lAht"
    alias lz="ls -lAhS"
fi

# ─── Safety Nets ──────────────────────────────────────────────────────────────
alias rm="rm -i"                 # Confirm before removing
alias cp="cp -i"                 # Confirm before overwriting
alias mv="mv -i"                 # Confirm before overwriting
alias mkdir="mkdir -pv"          # Create parents, verbose

# ─── Git ──────────────────────────────────────────────────────────────────────
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate -20"

# ─── Emacs ────────────────────────────────────────────────────────────────────
alias e="emacs"
alias ec="emacsclient -c"        # Open in existing Emacs
alias et="emacs -nw"             # Terminal mode

# ─── Clipboard ────────────────────────────────────────────────────────────────
copy-last-output() { eval $(fc -ln -1) 2>&1 | pbcopy }

# ─── Shortcuts ────────────────────────────────────────────────────────────────
alias c="clear"
alias h="history"
alias j="jobs -l"
alias path='echo -e ${PATH//:/\\n}'  # Pretty print PATH
alias reload="source ~/.zshrc"   # Reload this config
alias zshrc='${EDITOR} ~/.zshrc' # Edit this file

# ─── System ───────────────────────────────────────────────────────────────────
alias df="df -h"                 # Human readable disk usage
alias du="du -h"                 # Human readable file sizes
alias free="top -l 1 | head -n 10"  # Memory info (macOS)
alias ports="lsof -i -P -n | grep LISTEN"  # Show open ports

# ─── Development ──────────────────────────────────────────────────────────────
alias py="python3"
alias pip="pip3"
alias serve="python3 -m http.server"  # Quick HTTP server

# ─── Modern CLI Tools ────────────────────────────────────────────────────────
command -v bat &>/dev/null && alias cat="bat --style=auto"
command -v fastfetch &>/dev/null && alias fetch="fastfetch"


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                              Useful Functions                                │
# └──────────────────────────────────────────────────────────────────────────────┘

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.tar.xz)    tar xJf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *.rar)       unrar x "$1"    ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick find in current directory
f() {
    find . -name "*$1*" 2>/dev/null
}

# Quick grep with context
gr() {
    grep -rn --color=auto "$1" .
}

# Show directory size
dirsize() {
    du -sh "${1:-.}" 2>/dev/null
}

# Weather in terminal (requires internet)
weather() {
    curl -s "wttr.in/${1:-}"
}


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                         Secure Environment Variables                         │
# └──────────────────────────────────────────────────────────────────────────────┘

[ -f ~/.secure_env_vars ] && source ~/.secure_env_vars


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                            Version Managers                                  │
# └──────────────────────────────────────────────────────────────────────────────┘

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && source "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && source "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# pyenv (Python Version Manager)
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                                PATH Setup                                    │
# └──────────────────────────────────────────────────────────────────────────────┘

# Homebrew (Apple Silicon)
[[ -d "/opt/homebrew/bin" ]] && export PATH="/opt/homebrew/bin:$PATH"

# Java 21 (default)
if [[ -d "/opt/homebrew/opt/openjdk@21" ]]; then
  export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Emacs binaries (if installed via homebrew)
[[ -d "/opt/homebrew/opt/emacs-plus/bin" ]] && export PATH="/opt/homebrew/opt/emacs-plus/bin:$PATH"


# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                            Final Touches                                     │
# └──────────────────────────────────────────────────────────────────────────────┘

# Remove duplicate entries from PATH
typeset -U PATH path

# Disable ctrl+s freezing terminal
stty -ixon

# Welcome message (fastfetch if available, otherwise simple greeting)
if command -v fastfetch &>/dev/null; then
    fastfetch
else
    print -P "%F{cyan}Welcome back, %n%f"
fi


# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                           End of Configuration                               ║
# ╚══════════════════════════════════════════════════════════════════════════════╝
