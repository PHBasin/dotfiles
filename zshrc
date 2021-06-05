ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv ssh-agent colored-man-pages)

# Define a custom file for history and zcompdump
export HISTFILE="${HOME}/.oh-my-zsh/cache/.zsh_history"
export ZSH_COMPDUMP="${HOME}/.oh-my-zsh/cache/zcompdump-${HOST}-${ZSH_VERSION}"

# Define temporary files and directories
export TEMP=$(mktemp /tmp/tempfile.XXXXXXXX)
export TEMPDIR=$(mktemp -d /tmp/tempdir.XXXXXXXX)

# (macOS-only) Prevent Homebrew from reporting
export HOMEBREW_NO_ANALYTICS=1

# Define favorite browser
if [[ `uname -a` =~ "microsoft" ]]; then
  export BROWSER='"/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"'
fi

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load pyenv (to manage your Python versions)
#export PATH="${HOME}/.pyenv/bin:${PATH}" # Needed for Linux/WSL
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1 # https://github.com/pyenv/pyenv-virtualenv/issues/135
#type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
