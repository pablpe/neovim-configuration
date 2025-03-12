#!/bin/bash

echo "Updating package list..."
sudo apt update

# Install system dependencies
echo "Installing dependencies: git, ripgrep, fd-find, nodejs, npm, gcc, make..."
sudo apt install -y git ripgrep fd-find nodejs npm build-essential

# Install formatters for conform.nvim
echo "Installing formatters..."
npm install -g prettier # Add other formatters as needed

# Install LSP servers
echo "Installing language servers..."
npm install -g pyright lua-language-server

# Install Lazy.nvim if not already installed
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/lazy.nvim ]; then
    echo "Installing lazy.nvim..."
    git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/packer/start/lazy.nvim
fi

# Install Neovim plugins
echo "Installing plugins..."
nvim --headless +LazySync +qa

echo "Setup complete. You can now start Neovim!"
