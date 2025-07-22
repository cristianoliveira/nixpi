#!/bin/sh

# Define the variables here
source /etc/pihole/environment

WEBPASS=${PIHOLE_WEBPASS?"Missing password definition: PIHOLE_WEBPASS"}
SERVERIP=${PIHOLE_SEVICEIP?"Missing pihole server ip address: PIHOLE_SEVICEIP"}

docker run --name pihole \
  -p 53:53/tcp \
  -p 53:53/udp \
  -p 8053:80/tcp \
  -e TZ=Europe/Berlin \
  -e FTLCONF_webserver_api_password="$WEBPASS" \
  -e FTLCONF_dns_listeningMode=all \
  -v ./etc/pihole:/etc/pihole \
  -v ./etc/dnsmasq.d:/etc/dnsmasq.d \
  --restart unless-stopped \
  --dns=127.0.0.1 \
  pihole/pihole:latest

