# zsh basic

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

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
. /usr/local/opt/asdf/asdf.sh
. ~/.asdf/plugins/java/set-java-home.zsh

export PATH=$PATH:$HOME/go/bin
