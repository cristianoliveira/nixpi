#!/bin/sh

# Define the variables here
source /etc/pihole/environment

WEBPASS=${PIHOLE_WEBPASS?"Missing password definition: PIHOLE_WEBPASS"}
SERVERIP=${PIHOLE_SEVICEIP?"Missing pihole server ip address: PIHOLE_SEVICEIP"}

docker run --name pihole \
  --restart=unless-stopped \
  -p 53:53/tcp -p 53:53/udp \
  -p 4080:80/tcp \
  -p 443:443/tcp \
  -e TZ='Europe/Berlin' \
  -e WEBPASSWORD="$WEBPASS" \
  -e SERVERIP="$SERVERIP" \
  -v /var/lib/pihole/etc-pihole:/etc/pihole \
  -v /var/lib/pihole/etc-dnsmasq.d:/etc/dnsmasq.d \
  --dns=1.1.1.1 --dns=1.0.0.1 \
  --cap-add=NET_ADMIN \
  pihole/pihole:latest
