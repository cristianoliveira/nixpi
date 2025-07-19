#!/bin/sh

nixos-rebuild --experimental-features 'nix-command flakes' \
	switch --flake ~/nixpi#nixos

