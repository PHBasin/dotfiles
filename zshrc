ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search colored-man-pages pyenv ssh-agent docker docker-compose)

# Load Oh-My-Zsh
source ${ZSH}/oh-my-zsh.sh

# Define a custom file for history and zcompdump
export HISTFILE="${ZSH}/cache/.zsh_history"
export ZSH_COMPDUMP="${ZSH}/cache/zcompdump-${HOST}-${ZSH_VERSION}"

# Auto-completion
[ -s "${HOME}/.kube/config" ] && source <(kubectl completion zsh) && compdef kubecolor=kubectl
complete -C '/usr/local/bin/aws_completer' aws
complete -o nospace -C /home/phbasin/.tfenv/versions/1.2.3/terraform terraform

# Load Kubernetes configuration
source "${HOME}/dotfiles/load-k8s.sh"

# Load Pyenv (to manage your Python versions)
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

# Load NVM (to manage your node versions)
export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"
    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

