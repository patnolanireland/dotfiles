#!/bin/bash

echo "Starting Tmux setup..."

TPM_DIR="$HOME/.tmux/plugins/tpm"

# 1. Clone TPM if it doesn't exist
if [ ! -d "$TPM_DIR" ]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "TPM is already installed."
fi

# 2. Install plugins automatically
if [ -f "$HOME/.tmux.conf" ]; then
    echo "Installing/updating tmux plugins via TPM..."
    
    # Explicitly set the path so the headless server doesn't get confused
    export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
    
    "$TPM_DIR/bin/install_plugins"
else
    echo "Warning: ~/.tmux.conf not found. Skipping plugin installation."
fi

echo "Tmux setup complete!"

