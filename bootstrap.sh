#!/usr/bin/env bash
#
# Clone (or update) the dotfiles repository, then run install.sh.
#   curl -fsSL https://raw.githubusercontent.com/PHBasin/dotfiles/main/bootstrap.sh | bash
#
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/PHBasin/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/dotfiles}"

command -v git &>/dev/null || { echo "Git is not installed (sudo apt install git)." >&2; exit 1; }

if [[ -d "${DOTFILES_DIR}/.git" ]]; then
    echo "Updating ${DOTFILES_DIR}..."
    git -C "${DOTFILES_DIR}" pull --ff-only --quiet
else
    echo "Cloning ${REPO_URL} into ${DOTFILES_DIR}..."
    git clone -q "${REPO_URL}" "${DOTFILES_DIR}"
fi

bash "${DOTFILES_DIR}/install.sh"

echo
echo 'Your environment is ready to use 🎉'
