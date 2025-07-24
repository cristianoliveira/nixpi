#!/bin/bash

docker run -d \
	--name homeassist \
	--privileged \
	--restart=unless-stopped \
  -p 8123:8123 \
  -e TZ="Europe/Berlin"  \
  -v $HOME/.config/homeassitant:/config \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable
