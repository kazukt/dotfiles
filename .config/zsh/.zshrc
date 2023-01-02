#!/bin/zsh
#
# This file, .zshrc, is sourced by zsh for each interactive shell session.
#
# Note: For historical reasons, there are other dotfiles, besides .zshenv and
# .zshrc, that zsh reads, but there is really no need to use those.

autoload -Uz compinit && compinit

eval "$(/opt/homebrew/bin/brew shellenv)"

# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
typeset -U path

path=(
  "${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin"(N-/)
  "$(go env GOPATH)/bin"(N-/)
  "${HOME}/bin"(N-/)
  "$path[@]"
)

##
# History settings
#
# Always set these first, so history is preserved, no matter what happens.
#

# Tell zsh where to store history.
HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history

# Just in case: If the parent directory doesn't exist, create it.
# h removes a trailing pathname component, shortening the path by one directory level.
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

# Max number of entries to keep in history file.
SAVEHIST=$(( 100 * 1000 ))      # Use multiplication for readability.

# Max number of history entries to keep in memory.
HISTSIZE=$(( 1.2 * SAVEHIST ))  # Zsh recommended value

# Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_FCNTL_LOCK

# Keep only the most recent copy of each duplicate entry in history.
setopt HIST_IGNORE_ALL_DUPS

# Auto-sync history between concurrent sessions.
setopt SHARE_HISTORY

# fh - repeat history
fh() {
  # fc command: https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html
  BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')

  # Move the cursor to the end of the selected command.
  # https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#index-CURSOR
  CURSOR=${#BUFFER}
}
zle -N fh
bindkey '^r' fh

# asdf manages multiple runtime versions with a single CLI tool
# . /usr/local/opt/asdf/libexec/asdf.sh
# . ~/.asdf/plugins/java/set-java-home.zsh

# eval "$(starship init zsh)"

##
# Kubernetes
#

if type kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi
