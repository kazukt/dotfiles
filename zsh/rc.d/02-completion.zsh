#!/bin/zsh

##
# Completion settings
#

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit && compinit

# Kubernetes
source <(kubectl completion zsh)
