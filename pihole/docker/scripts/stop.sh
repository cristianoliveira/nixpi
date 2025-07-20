#!/bin/sh

docker stop pihole || echo "already stopped"
docker rm -f pihole
