ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-autosuggestions zsh-syntax-highlighting history-substring-search colored-man-pages pyenv ssh-agent docker docker-compose)

# Zsh history
export HISTFILE="${ZSH}/cache/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=${HISTSIZE}
export ZSH_COMPDUMP="${ZSH}/cache/zcompdump-${HOST}-${ZSH_VERSION}"

# Load Oh-My-Zsh
source ${ZSH}/oh-my-zsh.sh

# Zsh History Options
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Python
if command -v pyenv 1>/dev/null 2>&1; then
  RPROMPT+='[🐍 $(pyenv_prompt_info)]'
fi

# NVM
export NVM_DIR="${HOME}/.nvm"
if [ -s "${NVM_DIR}/nvm.sh" ]; then
  \. "${NVM_DIR}/nvm.sh"
  [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"
  # Auto-load NVM version on directory change
  autoload -U add-zsh-hook
  load-nvmrc() {
    local nvmrc_path="$(nvm_find_nvmrc 2>/dev/null)"
    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")" 2>/dev/null)
      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$(nvm version 2>/dev/null)" ]; then
        nvm use --silent
      fi
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# Kubernetes
# if [ -s "${HOME}/.kube/config" ]; then
#   source <(kubectl completion zsh)
#   compdef kubecolor=kubectl
#   source "${HOME}/dotfiles/load-k8s.sh"
#   RPROMPT+=' [🐋 $ZSH_KUBECTL_NAMESPACE]'
# fi

# Aliases
[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"
