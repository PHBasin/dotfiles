#!/bin/bash
set -e

# Update
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates \
                    curl \
                    wget \
                    vim \
                    jq \
                    git \
                    unzip \
                    tree \
                    zsh

# Setup dotfiles
backup() {
    target=$1
    if [ -e "$target" ]; then           # Does the config file already exist?
        if [ ! -L "$target" ]; then       # as a pure file, ie not a symlink?
        mv "$target" "$target.backup"   # Then backup it
        echo "-----> Moved your old $target config file to $target.backup"
        fi
    fi
}

symlink() {
    file=$1
    link=$2
    if [ ! -e "$link" ]; then
        echo "-----> Symlinking your new $link"
        ln -s "$file" "$link"
    fi
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
for path in "$SCRIPT_DIR"/*; do
    name=$(basename "$path")
    target="$HOME/.$name"
    if [[ ! "$name" =~ \.sh$ ]] && [[ "$name" != 'settings.json' ]]; then
        backup "$target"
        symlink "$path" "$target"
    fi
done

# Oh My Zsh
ZSH_DIR="$HOME/.oh-my-zsh"
if [ ! -e "$ZSH_DIR" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
fi
sudo chsh --shell /usr/bin/zsh $(whoami)

# Zsh plugin
CURRENT_DIR=$(pwd)
ZSH_PLUGINS_DIR="$ZSH_DIR/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR" || exit
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
    git clone https://github.com/zsh-users/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting
fi
cd "$CURRENT_DIR" || exit

# Terminal settings
#WT_PATH=~/.vscode-server/data/Machine
#if [ -e $CODE_PATH ]; then
#  target="$CODE_PATH/settings.json"
#  backup $target
#  symlink $PWD/settings.json $target
#fi

# Python
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.10.6
pyenv global 3.10.6

zsh ~/.zshrc

echo "👌 Everything went well"
