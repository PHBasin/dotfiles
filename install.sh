#!/usr/bin/env bash

# System update and
CORE_PACKAGES=(
    "ca-certificates" "curl" "wget" "vim" "jq" "git" "unzip" "tree" "zsh"
)

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing core dependencies..."
sudo apt install -y "${CORE_PACKAGES[@]}"

# Oh My Zsh and plugins
ZSH_DIR="${HOME}/.oh-my-zsh"
ZSH_PLUGINS=(
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

if [ ! -d "${ZSH_DIR}" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed. Skipping..."
fi

echo "Setting Zsh as the default shell..."
sudo chsh --shell /usr/bin/zsh "$(whoami)"

ZSH_PLUGINS_DIR="${ZSH_DIR}/custom/plugins"
mkdir -p "${ZSH_PLUGINS_DIR}"

for plugin_name in "${ZSH_PLUGINS[@]}"; do
    target_dir="${ZSH_PLUGINS_DIR}/${plugin_name}"
    repo_url="https://github.com/zsh-users/${plugin_name}.git"
    if [ ! -d "${target_dir}" ]; then
        echo "-----> Installing plugin: ${plugin_name}..."
        git clone "${repo_url}" "${target_dir}"
    else
        echo "-----> Plugin ${plugin_name} is already installed."
    fi
done

# Dotfiles functions
remove_existing() {
    target=$1
    if [ -e "${target}" ] || [ -L "${target}" ]; then
        rm -rf "${target}"
        echo "-----> Removed existing configuration: ${target}"
    fi
}

symlink() {
    file=$1
    link=$2
    if [ ! -e "${link}" ]; then
        echo "-----> Symlinking: ${link} -> ${file}"
        ln -s "${file}" "${link}"
    fi
}

# Linking Dotfiles
echo "Configuring dotfiles..."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for filepath in "$SCRIPT_DIR"/*; do
    name=$(basename "${filepath}")
    target="${HOME}/.$name"

    if [[ ! "$name" =~ \.sh$ ]] && [[ "$name" != 'settings.json' ]] && [[ "$name" != 'README.md' ]]; then
        remove_existing "${target}"
        symlink "${filepath}" "${target}"
    fi
done

# Terminal Settings
# CODE_PATH="${HOME}/.vscode-server/data/Machine"

# if [ -d "${CODE_PATH}" ]; then
#     echo "Configuring VS Code Server settings..."
#     target="${CODE_PATH}/settings.json"
#     remove_existing "${target}"
#     symlink "${SCRIPT_DIR}/settings.json" "${target}"
# fi

# Python & Pyenv
PYTHON_VERSION="3.10.6"
PYENV_DEPENDENCIES=(
    "build-essential" "libssl-dev" "zlib1g-dev" "libbz2-dev"
    "libreadline-dev" "libsqlite3-dev" "llvm" "libncursesw5-dev"
    "xz-utils" "tk-dev" "libxml2-dev" "libxmlsec1-dev" "libffi-dev"
    "liblzma-dev"
)

if [ ! -d "${HOME}/.pyenv" ]; then
    echo "Installing pyenv dependencies..."
    sudo apt install -y "${PYENV_DEPENDENCIES[@]}"

    echo "Cloning pyenv repository..."
    git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
else
    echo "pyenv is already installed. Skipping..."
fi

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    if ! pyenv versions | grep -q "${PYTHON_VERSION}"; then
        echo "Installing Python ${PYTHON_VERSION} via pyenv (this may take a few minutes)..."
        pyenv install "${PYTHON_VERSION}"
    else
        echo "Python ${PYTHON_VERSION} is already installed. Skipping..."
    fi

    echo "Setting Python ${PYTHON_VERSION} as global version..."
    pyenv global "${PYTHON_VERSION}"
fi

echo ''
echo "👌 Everything went well (Restart your terminal or run 'exec zsh')"
