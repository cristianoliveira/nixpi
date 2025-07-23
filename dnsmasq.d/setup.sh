#!/bin/sh

# Make sure to enable it on:
# Settings > All Settings > Miscellaneous > misc.etc_dnsmasq_d

# Generate a new dnsmasq configuration entry
# dnsmasq.d/01-catchall.conf
# with the following content:
# address=/nixpi.lab/(current IP address of the device)

sudo mkdir /etc/dnsmasq.d

CURRENT_IP=$(ip addr show | grep 'inet 192' | awk '{print $2}' | cut -d'/' -f1)
echo "Current IP: $CURRENT_IP"

sudo cat > /etc/dnsmasq.d/01-catchall.conf <<EOF
address=/nixpi.lab/$CURRENT_IP
address=/local.lab/127.0.0.1
EOF
