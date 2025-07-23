#!/bin/sh

sudo nixos-rebuild switch --flake ~/nixpi#nixos

git add -p
