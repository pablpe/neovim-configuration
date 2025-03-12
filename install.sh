#!/bin/bash

echo "Updating package list..."
sudo apt update

# Install Neovim if not installed
if ! command -v nvim &>/dev/null; then
    echo "Installing Neovim..."
    sudo apt install -y neovim
fi

# Install system dependencies
echo "Installing dependencies: git, ripgrep, fd-find, nodejs, npm, gcc, make..."
sudo apt install -y git ripgrep fd-find nodejs npm build-essential

# Install formatters and LSP servers
echo "Installing formatters and LSP servers..."
sudo npm install -g prettier pyright typescript-language-server

# Install lua-language-server separately
echo "Installing lua-language-server..."
sudo apt install -y lua-language-server

# Install Lazy.nvim if not already installed
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/lazy.nvim ]; then
    echo "Installing lazy.nvim..."
    git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/packer/start/lazy.nvim
fi

# Install Neovim plugins
echo "Installing plugins..."
nvim --headless +LazySync +qa

# Run Mason to install missing LSPs
echo "Installing LSPs using Mason..."
nvim --headless -c "MasonInstall lua-language-server pyright tsserver gopls rust_analyzer" -c "q"

echo "Setup complete. You can now start Neovim!"

