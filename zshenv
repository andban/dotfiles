#
# ~/.zshenv
#
# setting up environment
#

# use path_helper and /etc/paths.d on MacOS X
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
fi

export TERM=xterm-256color

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# setup editor and pager
export EDITOR="subl -w -n"
export VISUAL='subl -w -n'
export PAGER="less"
export LESS="--ignore-case --raw-control-chars"

export LC_COLLATE=C


# setup rbenv, if present
if which rbenv &> /dev/null; then
    export PATH="$HOME/.rbenv/bin:$PATH"çƒ
    eval "$(rbenv init -)"
fi

# setup pip
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
