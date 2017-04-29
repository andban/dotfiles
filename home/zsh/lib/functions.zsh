# create and change into new directory
function mk() {
  mkdir -p "$@" && cd "$@"
}

# extract compressed files
function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2 | *.tbz2)
        tar -jxvf "$1"
        ;;
      *.tar.gz | *.tgz)
        tar -zxvf "$1"
        ;;
      *.bz2)
        bunzip2 "$1"
        ;;
      *.gz)
        gunzip "$1"
        ;;
      *.tar)
        tar -xvf "$1"
        ;;
      *.zip)
        unzip "$1"
        ;;
      *)
        echo "'$1' cannot be extracted via extract()"
        ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

dnsmasq-restart(){
  echo "Restarting dnsmasq..."
  sudo launchctl stop homebrew.mxcl.dnsmasq
  sudo launchctl start homebrew.mxcl.dnsmasq
}

# create custom dns tld entry for local host
# @1 the tld of the machine (for example 'dev')
create-dns() {
  local ip="127.0.0.1"
  local dnsconf=/usr/local/etc/dnsmasq.conf
  if [ ! -e /etc/resolver/$1 ]; then
    echo "adding $1 entry to resolvers"
    sudo tee /etc/resolver/$1 >/dev/null <<EOF
nameserver 127.0.0.1
EOF
  fi

  if grep -q /$1/$ip $dnsconf; then
    echo "correct dnsmasq entry already exists"
  elif grep -q ^address=/$1/ $dnsconf; then
    echo "hostname $1 already present in dnsmasq - updating"
    sed -i '' -E "\%^address=/[[:alnum:]_.-]+/$ip%d" $dnsconf
    sed -i '' -E "s%^(address=/$1)/([[:digit:].]+)$%\1/$ip%g" $dnsconf
    dnsmasq-restart
  else
    echo "adding $1/$ip entry to dnsmasq"
    echo "address=/$1/$ip" >> /usr/local/etc/dnsmasq.conf
    dnsmasq-restart
  fi
}

function somafm() {
  local station="$1"
  mplayer -playlist "http://somafm.com/${station}.pls"
}

function dradio() {
  local station=
  case "$1" in
    "nova")   station="deutschlandfunknova" ;;
    "kultur") station="dkultur" ;;
    "dlf")    ;&
    *)        station="dlf" ;;
  esac
  mplayer -playlist "http://www.dradio.de/streaming/${station}.m3u"
}
