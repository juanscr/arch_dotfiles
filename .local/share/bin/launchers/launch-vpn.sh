#!/bin/sh

sudo true;
sudo openfortivpn -c /etc/openfortivpn/config --pppd-accept-remote &
PID=$!
sleep 5
source ~/.local/share/bin/launchers/private-dns-variables.sh
while true; do
    sudo resolvectl dns ppp0 $dns_server \
        && sudo resolvectl domain ppp0 ~. $domain_name \
        && break
done;
unset dns_server
unset domain_name
while true; do sleep 60; done;
kill $PID
