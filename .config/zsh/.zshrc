#!/bin/zsh
#
# This file, .zshrc, is sourced by zsh for each interactive shell session.
#
# Note: For historical reasons, there are other dotfiles, besides .zshenv and
# .zshrc, that zsh reads, but there is really no need to use those.

autoload -Uz compinit && compinit

# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
typeset -U path

path=(
  "$(go env GOPATH)/bin"(N-/)
  "${HOME}/bin"(N-/)
  "$path[@]"
)

# The construct below is what Zsh calls an anonymous function; most other
# languages would call this a lambda or scope function. It gets called right
# away with the arguments provided and is then discarded.
# Here, it enables us to use scoped variables in our dotfiles.
() {
  # `local` sets the variable's scope to this function and its descendendants.
  local gitdir=~/Git  # Where to keep repos and plugins

  # Load all of the files in rc.d that start with <number>- and end in .zsh
  # (n) sorts the results in numerical order.
  # <-> is an open-ended range. It matches any non-negative integer.
  # <1-> matches any integer >= 1. <-9> matches any integer <= 9.
  # <1-9> matches any integer that's >= 1 and <= 9.
  local file=
  for file in $ZDOTDIR/rc.d/<->-*.zsh(n); do
    . $file
  done
} "$@"
# $@ expands to all the arguments that were passed to the current context (in
# this case, to `zsh` itself).
# "Double quotes" ensures that empty arguments '' are preserved.
# It's a good practice to pass "$@" by default. You'd be surprised at all the
# bugs you avoid this way.

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
. /usr/local/opt/asdf/libexec/asdf.sh
. ~/.asdf/plugins/java/set-java-home.zsh

eval "$(starship init zsh)"
