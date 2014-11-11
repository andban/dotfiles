#
# ~/.zsh/lib/prompt.zsh
#
#


function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo "($(basename $VIRTUAL_ENV)) "
}

# enable colors
autoload -U colors && colors

# default prompt
PS1="%n@%m:%~%# "

# load prompt
autoload -U promptinit
promptinit

setopt prompt_subst

# only show rpromp on active prompt
setopt transient_rprompt


# enable vcs modules
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%B*%b'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%B+%b'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '[%b%|%a%c%u%]%f'
zstyle ':vcs_info:*' formats ':%b%c%u%f'

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

precmd () {
    vcs_info
}

PROMPT='   %(#~!~@) %. > '

RPROMPT='${vcs_info_msg_0_}'
