#!/usr/bin/env bash
set -e

USER="PHBasin"
REPO_URL="https://github.com/${USER}/dotfiles.git"
DOTFILES_DIR="${HOME}/dotfiles"

# Git
if ! command -v git &> /dev/null; then
    echo "Git is not installed."
    exit 1
fi

# Clone dotfiles
if [ -d "${DOTFILES_DIR}" ]; then
    echo "Pulling the latest changes from the repository..."
    cd "${DOTFILES_DIR}"
    git pull origin main --quiet
    echo "Repository ${DOTFILES_DIR} updated."
else
    echo "Cloning the dotfiles repository..."
    git clone -q "${REPO_URL}" "${DOTFILES_DIR}"
fi

# Installation script
if [ -f "${DOTFILES_DIR}/install.sh" ]; then
    echo "Starting installation script..."
    cd "${DOTFILES_DIR}"
    chmod +x install.sh
    ./install.sh
else
    echo "install.sh was not found in the repository"
    exit 1
fi

echo ''
echo 'Your environment is ready to use 🎉'
