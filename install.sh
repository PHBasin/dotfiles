#!/bin/zsh

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
    ln -s $file $link
  fi
}

for name in *; do
  if [ ! -a "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ] && [[ "$name" != 'settings.json' ]] && [[ "$name" != 'config' ]]; then
      backup $target
      symlink $PWD/$name $target
    fi
  fi
done

# Install zsh-syntax-highlighting plugin
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone https://github.com/zsh-users/zsh-autosuggestions
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
fi
cd "$CURRENT_DIR"

# Symlink VS Code settings
#CODE_PATH=~/.vscode-server/data/Machine
#if [ -e $CODE_PATH ]; then
#  target="$CODE_PATH/settings.json"
#  backup $target
#  symlink $PWD/settings.json $target
#fi

zsh ~/.zshrc

echo "👌 Everything went well"
