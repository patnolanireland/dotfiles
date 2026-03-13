#!/bin/bash

echo "Starting system bootstrap..."

# Detect the base operating system
OS="$(uname -s)"

# ---------------------------------------------------------
# macOS Setup (M3)
# ---------------------------------------------------------
if [ "$OS" = "Darwin" ]; then
    echo "macOS detected. Checking for Homebrew..."
    
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    echo "Installing core dependencies via Homebrew..."
    brew update
    # Removed 'rust' from this list
    brew install neovim tmux cmake gcc ripgrep fd luarocks python go

    echo "Updating Python Neovim provider..."
    pip3 install --user --upgrade pynvim --break-system-packages

# ---------------------------------------------------------
# Linux Setup (Ubuntu/WSL)
# ---------------------------------------------------------
elif [ "$OS" = "Linux" ]; then
    
    if uname -a | grep -qFi 'microsoft' || uname -a | grep -qFi 'wsl'; then
        IS_WSL=true
    else
        IS_WSL=false
    fi

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        
        if [ "$ID" = "ubuntu" ] || [[ "$ID_LIKE" == *"debian"* ]]; then
            
            echo "Installing core dependencies via apt..."
            sudo apt-get update
            
            sudo apt-get install -y silversearcher-ag curl neovim tmux cmake build-essential unzip git ripgrep fd-find python3-pip python3-venv luarocks golang-go php composer tree fzy
            
            # Fix fd naming for Telescope
            mkdir -p "$HOME/.local/bin"
            if [ ! -L "$HOME/.local/bin/fd" ]; then
                ln -s "$(which fdfind)" "$HOME/.local/bin/fd"
            fi
            export PATH="$HOME/.local/bin:$PATH"

		  # WSL-specific Clipboard bridging
		  if [ "$IS_WSL" = true ]; then
                echo "WSL detected: Installing win32yank for Neovim clipboard support..."
                mkdir -p "$HOME/.local/bin"
                if [ ! -f "$HOME/.local/bin/win32yank.exe" ]; then
                    curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
                    unzip -p /tmp/win32yank.zip win32yank.exe > "$HOME/.local/bin/win32yank.exe"
                    chmod +x "$HOME/.local/bin/win32yank.exe"
                    rm /tmp/win32yank.zip
                else
                    echo "win32yank.exe already installed."
                fi
            fi

            echo "Updating Python Neovim provider..."
            pip3 install --user --upgrade pynvim --break-system-packages
            
        else
            echo "Linux distribution '$NAME' detected. Automated install unsupported."
            exit 1
        fi
    else
        echo "Cannot determine Linux distribution (/etc/os-release missing)."
        exit 1
    fi

else
    echo "Unsupported OS: $OS"
    exit 1
fi

# ---------------------------------------------------------
# Cross-Platform Setup (Node.js & Rust)
# ---------------------------------------------------------
echo "Installing NVM and Node.js LTS..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM into the current session
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

echo "Installing tree-sitter-cli..."
npm install -g tree-sitter-cli
npm install -g neovim

echo "Installing Rust toolchain..."
if ! command -v cargo &> /dev/null; then
    # This installs rustc, cargo, and rustup automatically on macOS and Linux
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    
    rustup component add rust-analyzer
else
    echo "Rust is already installed."
fi

echo "Installing SDKMAN! (Java Environment Manager)..."
export SDKMAN_DIR="$HOME/.sdkman"
if [ ! -d "$SDKMAN_DIR" ]; then
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
fi

# Load SDKMAN! into the current session
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    
    # Install the latest LTS version of OpenJDK (Eclipse Temurin)
    echo "Installing latest OpenJDK LTS..."
    sdk install java
    
    # Install your other JVM build tools from your old config
    echo "Installing Maven and Leiningen..."
    sdk install maven
    sdk install leiningen
else
    echo "SDKMAN! installation failed or is not available."
fi

echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # The --unattended flag prevents the installer from pausing the script
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) \"\" --unattended"
else
    echo "Oh My Zsh is already installed."
fi

# Make Zsh the default shell if it isn't already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s $(which zsh)
fi

echo "========================================"
echo "System dependencies installed successfully!"
echo "NOTE: Please restart your terminal for NVM, Cargo, and SDKMAN! paths to take effect."
echo "========================================"
