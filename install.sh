#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "Creating symlinks..."

# Neovim
mkdir -p "$HOME/.config"
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Tmux
ln -snf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Zsh
ln -snf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "Symlinks created!"

# Run component-specific setups
echo "Running component setups..."

if [ -x "$DOTFILES_DIR/tmux/setup.sh" ]; then
    "$DOTFILES_DIR/tmux/setup.sh"
fi

echo "All done! You are ready to go."
