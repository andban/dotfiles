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
    openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -keyout "${tld}.key" -out "${tld}.crt" -config "/tmp/openssl.cnf"

    rm /tmp/openssl.cnf
}

# ssh-agent on demand
if which ssh-ident > /dev/null; then
  alias ssh=ssh-ident
fi


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
alias glf='git log-full'

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

# Docker
######################################################################
dc-exec() {
  local arg
  if [ "$#" -gt 1 ]; then
    arg="${@:2}"
  else
    arg="bash"
  fi

  docker exec -it "${PWD##*/}_$1_1" $arg
}

dm-env() {
  eval $(docker-machine env $1)
}

dnsmasq-restart(){
  echo "Restarting dnsmasq..."
  sudo launchctl stop homebrew.mxcl.dnsmasq
  sudo launchctl start homebrew.mxcl.dnsmasq
}

dm-dns() {
  local dmip=$(docker-machine ip $1)
  local dnsconf=/usr/local/etc/dnsmasq.conf
  if [ ! -e /etc/resolver/$1 ]; then
    echo "adding $1 entry to resolvers"
    sudo tee /etc/resolver/$1 >/dev/null <<EOF
nameserver 127.0.0.1
EOF
  fi

  if grep -q /$1/$dmip $dnsconf; then
    echo "correct dnsmasq entry already exists"
  elif grep -q ^address=/$1/ $dnsconf; then
    echo "hostname $1 already present in dnsmasq - updating"
    sed -i '' -E "\%^address=/[[:alnum:]_.-]+/$dmip%d" $dnsconf
    sed -i '' -E "s%^(address=/$1)/([[:digit:].]+)$%\1/$dmip%g" $dnsconf
    dnsmasq-restart
  else
    echo "adding $1/$dmip entry to dnsmasq"
    echo "address=/$1/$dmip" >> /usr/local/etc/dnsmasq.conf
    dnsmasq-restart
  fi
}

dm-start() {
  docker-machine start $1
  dm-dns $1
  dm-env $1
}

alias doco='docker-compose'
alias doco-rc='docker-compose up -d --force-recreate --no-deps'
alias doco-rcb='docker-compose up -d --force-recreate --no-deps --build'

alias d='docker'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'

alias dterm='docker run -it --rm --privileged --pid=host justincormack/nsenter1'

#
# Random stuff
##############################################################################
alias ocean='play -c 2 -n synth pinknoise band -n 2500 4000 tremolo 0.03 5 reverb 20 gain'
alias enterprise='play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20'
