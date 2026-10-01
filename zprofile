# Encoding
export LANG=en_US.UTF-8

# Default applications
export EDITOR=vim
if [[ -n "${WSL_DISTRO_NAME}" ]]; then
  export BROWSER='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
fi

# Python configurations
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONHISTORY="$HOME/.cache/.python_history"

# Keep PATH entries unique
typeset -U path PATH

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT/bin" ]]; then
  path=("$PYENV_ROOT/bin" $path)
  eval "$(pyenv init --path)"
fi

# User binaries (Claude Code, pipx...)
path=("$HOME/.local/bin" $path)

# AWS
export AWS_PAGER=""
