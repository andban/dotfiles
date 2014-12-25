#
# aliases and functions
#

# Misc
########################################################################

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias ...='cd ../..'

# colored grep results
alias grep='grep --color=auto'

# don't wrap lines in nano
alias nano='nano -w'

# custom tmux term id
alias tmux='TERM=screen-256color tmux'

# clear screen
alias cls='echo -ne "\033c"'

# root shell
alias root='sudo -s'


function h() {
   history 0 | grep --color=always $@ | uniq -f 1
}

function find-exec() {
    find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

function edit() {
    local file=$1
    [[ -z "$file" ]] && file='.'
    eval $EDITOR $file
}
alias e='edit'

# create a SSL certificate for $1 as tld
function ssl_cert() {
    local tld=$1

    cat > /tmp/openssl.cnf <<-EOF
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no
[req_distinguished_name]
CN = *.${tld}
[v3_req]
keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = *.${tld}
DNS.2 = ${tld}
EOF
    openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -keyout "${tld}.key" -out "${tld}.crt" -config "/tmp/openssl.cnf"

    rm /tmp/openssl.cnf
}

# GIT
#######################################################################

alias g='git'
alias ga='git add'
alias gr='git rm'
alias gf='git fetch'
alias gu='git pull'
alias gup='git pull && git push'
alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --no-merges'

function gc() {
    local args=$@
    git commit -m "$args"
}

function gca() {
    local args=$@
    git commit --amend -m "$args"
}


# MacOS
#######################################################################

if [[ $OS_FAMILY == "Darwin" ]]; then
    if [ -x ~/Applications/love.app/Contents/MacOS/love ]; then
        alias love="~/Applications/love.app/Contents/MacOS/love"
    fi

    # use case insensitive matching and show full paths to binaries
    alias pgrep='prgep -fli'
else
    # no case insensitive matchin :(
    alias pgrep='pgrep -fl'
fi


# Arch Linux
########################################################################
if [[ $OS_FLAVOR == "Arch" ]]; then
    # update and upgrade packages
    alias pacu='sudo pacman -Syu'

    # install package
    alias paci='sudo pacman -S'

    # remove package / package and everything attached to it
    alias pacr='sudo pacman -R'
    alias pacra='sudo pacman -Rns'

    alias pacs='pacman -Ss'
fi
