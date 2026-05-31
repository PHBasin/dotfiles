# Encoding
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default applications
export EDITOR=vim
export BROWSER='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'

# Python configurations
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONHISTORY="$HOME/.cache/.python_history"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
