#!/usr/bin/env bash

sudo mkdir -p /etc/pihole
sudo mkdir -p /opt/pihole

sudo ln -sf $HOME/nixpi/pihole/docker/scripts /opt/pihole/
