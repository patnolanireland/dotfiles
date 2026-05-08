# ==============================================================================
# Oh My Zsh Configuration
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

# Theme
ZSH_THEME="agnoster"
HIST_STAMPS="dd.mm.yyyy"

# Plugins
plugins=(git zsh-syntax-highlighting tmux)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# History Settings
# ==============================================================================
# Increase history size to 100,000 lines
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"

# Force the 'history' command to act like Bash and print everything
alias history="history 1"

# ==============================================================================
# OS Detection & Environment Setup
# ==============================================================================
OS="$(uname -s)"

# Base PATH
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

if [ "$OS" = "Darwin" ]; then
    # ---------------------------------------------------------
    # macOS Setup (M3)
    # ---------------------------------------------------------
    
    # 1. Homebrew
    if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # 2. Google Cloud SDK
    if command -v brew &> /dev/null && [ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]; then
        source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
        source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
    fi

    # 3. macOS Specific PATHs
    export PATH="$PATH:/opt/homebrew/opt/mysql-client/bin:/opt/homebrew/opt/curl/bin"
    export PATH="$PATH:$HOME/Software/git/depot_tools:$HOME/.composer/vendor/bin"
    export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
    export PATH="$PATH:$HOME/.cache/lm-studio/bin"

    # 4. SSH Agent & Keychain
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        eval "$(ssh-agent -s)"
    fi
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519 >/dev/null 2>&1
    ssh-add ~/.ssh/id_bjp_wontok >/dev/null 2>&1

    # 5. Perl
    if [ -d "$HOME/perl5" ]; then
        eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
    fi

    # 6. jEnv (macOS Java)
    if [ -d "$HOME/.jenv" ]; then
        export PATH="$HOME/.jenv/bin:$PATH"
        eval "$(jenv init -)"
    fi

    # 7. pnpm (macOS Path)
    export PNPM_HOME="$HOME/Library/pnpm"

elif [ "$OS" = "Linux" ]; then
    # ---------------------------------------------------------
    # WSL2 / Linux Setup
    # ---------------------------------------------------------
    
    # 1. WSL Clipboard Bridging
    if uname -a | grep -qFi 'microsoft' || uname -a | grep -qFi 'wsl'; then
        alias pbcopy='clip.exe'
        alias pbpaste='powershell.exe -Command Get-Clipboard | sed "s/\r$//"'
    fi

    # 2. pnpm (Linux Path)
    export PNPM_HOME="$HOME/.local/share/pnpm"
fi

# ==============================================================================
# Cross-Platform Toolchains
# ==============================================================================

# 1. PNPM Path Injection
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# 2. Rust / Cargo
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
if [ -f "$HOME/.local/bin/env" ]; then
    source "$HOME/.local/bin/env"
fi

# 3. NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 4. SDKMAN! (Linux Java/Maven/Leiningen)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# ==============================================================================
# General Aliases & Exports
# ==============================================================================
export EDITOR='nvim'

alias vim="nvim"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
