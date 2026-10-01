#!/usr/bin/env bash
#
# Install system packages, Oh My Zsh, pyenv and symlink dotfiles into $HOME.
# Idempotent: safe to run several times.
#
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BACKUP_DIR="${HOME}/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
PYTHON_VERSION="${PYTHON_VERSION:-3.10.6}"

# Files in the repo symlinked to ~/.<name>
DOTFILES=(aliases gitconfig vim zprofile zshrc)

CORE_PACKAGES=(ca-certificates curl wget vim jq git unzip tree zsh)

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PYENV_DEPENDENCIES=(
    build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev
    libsqlite3-dev libncurses-dev xz-utils tk-dev libxml2-dev
    libxmlsec1-dev libffi-dev liblzma-dev
)

ZSH_DIR="${HOME}/.oh-my-zsh"
ZSH_PLUGINS=(zsh-autosuggestions zsh-syntax-highlighting)

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
step() { printf '    %s\n' "$*"; }
die()  { printf '\033[1;31mError:\033[0m %s\n' "$*" >&2; exit 1; }

install_packages() {
    command -v apt-get &>/dev/null || die "apt-get not found: only Debian/Ubuntu are supported."

    info "Updating system packages..."
    sudo apt-get update -q
    sudo apt-get upgrade -yq

    info "Installing core dependencies..."
    sudo apt-get install -yq "${CORE_PACKAGES[@]}"
}

install_oh_my_zsh() {
    if [[ -d "${ZSH_DIR}" ]]; then
        info "Oh My Zsh already installed, skipping."
    else
        info "Installing Oh My Zsh..."
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    local plugins_dir="${ZSH_DIR}/custom/plugins"
    mkdir -p "${plugins_dir}"
    for plugin in "${ZSH_PLUGINS[@]}"; do
        if [[ -d "${plugins_dir}/${plugin}" ]]; then
            step "Plugin ${plugin} already installed."
        else
            step "Installing plugin ${plugin}..."
            git clone -q --depth=1 "https://github.com/zsh-users/${plugin}.git" "${plugins_dir}/${plugin}"
        fi
    done

    local zsh_path
    zsh_path="$(command -v zsh)"
    if [[ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "${zsh_path}" ]]; then
        info "Setting Zsh as the default shell..."
        sudo chsh --shell "${zsh_path}" "$(id -un)"
    fi
}

# Symlink ~/.<name> -> repo/<name>, backing up any existing real file.
link_dotfiles() {
    info "Linking dotfiles..."
    for name in "${DOTFILES[@]}"; do
        local source="${DOTFILES_DIR}/${name}"
        local target="${HOME}/.${name}"

        [[ -e "${source}" ]] || die "Missing ${source}"

        if [[ -L "${target}" && "$(readlink -- "${target}")" == "${source}" ]]; then
            step "${target} already linked."
            continue
        fi

        if [[ -e "${target}" || -L "${target}" ]]; then
            mkdir -p "${BACKUP_DIR}"
            mv -- "${target}" "${BACKUP_DIR}/"
            step "Backed up ${target} to ${BACKUP_DIR}/"
        fi

        ln -s -- "${source}" "${target}"
        step "Linked ${target} -> ${source}"
    done
}

install_pyenv() {
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"

    if [[ -d "${PYENV_ROOT}" ]]; then
        info "pyenv already installed, skipping."
    else
        info "Installing pyenv and its build dependencies..."
        sudo apt-get install -yq "${PYENV_DEPENDENCIES[@]}"
        git clone -q --depth=1 https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"
    fi

    eval "$(pyenv init --path)"

    if pyenv versions --bare | grep -qxF "${PYTHON_VERSION}"; then
        info "Python ${PYTHON_VERSION} already installed, skipping."
    else
        info "Installing Python ${PYTHON_VERSION} (this may take a few minutes)..."
        pyenv install "${PYTHON_VERSION}"
    fi
    pyenv global "${PYTHON_VERSION}"
}

main() {
    install_packages
    install_oh_my_zsh
    link_dotfiles
    install_pyenv

    echo
    info "Done. Restart your terminal or run 'exec zsh'."
}

main "$@"
