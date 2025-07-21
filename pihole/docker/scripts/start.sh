#!/bin/sh

# Define the variables here
source /etc/pihole/environment

WEBPASS=${PIHOLE_WEBPASS?"Missing password definition: PIHOLE_WEBPASS"}
SERVERIP=${PIHOLE_SEVICEIP?"Missing pihole server ip address: PIHOLE_SEVICEIP"}

docker run  \
  --name pihole \
  -p 53:53/tcp \
  -p 53:53/udp \
  -p 80:80/tcp \
  -p 443:443/tcp \
  -e TZ=Europe/London \
  -e FTLCONF_webserver_api_password="$WEBPASS" \
  -e FTLCONF_dns_listeningMode=all \
  -v /etc/pihole:/etc/pihole \
  -v /etc/dnsmasq.d:/etc/dnsmasq.d \
  --cap-add NET_ADMIN \
  --restart unless-stopped \
  --dns=1.1.1.1 --dns=1.0.0.1 \
  pihole/pihole:latest
