#!/bin/sh

if ! [ "$(command -v dnsmasq)" ]; then
  echo "please install dnsmasq first!"
  exit 0
fi

CONFIG="$(brew --prefix)/etc/dnsmasq.conf"

echo "port=5354\naddress=/.test/127.0.0.1" >> $CONFIG

brew services start dnsmasq

sudo mkdir -p /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1\nport 5354"' > /etc/resolver/test

