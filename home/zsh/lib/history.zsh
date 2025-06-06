if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=200
SAVEHIST=${HISTSIZE}

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
