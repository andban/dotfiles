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

# gather info about the system
export OS_FAMILY=$(uname -s)
export OS_FLAVOR=$OS_FAMILY
export OS_RELEASE=$(uname -r)

if [ -f /etc/arch-release ]; then
    OS_FLAVOR='Arch'
elif [ -f /etc/debian_version ] || [ -f /etc/lsb-release ]; then
    OS_FLAVOR='Debian'
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
