#!/bin/sh

set -e

[ -e "/run/current-system" ] && {
  echo >&2 "This is a NixOS, so we just remove /nix/var/nix/gcroots/auto/ceh/*!"
  set -x
  rm -rf /nix/var/nix/profiles/ceh/*        # outdated, but delete for old ceh versions
  rm -rf /nix/var/nix/gcroots/auto/ceh/*
  exit 0
}

set -x

chmod -R +w /nix
shopt -s dotglob
rm -rf /nix/*
rm -f ~/.nix-profile
rm -f ~/.nix-channels
rm -rf ~/.nix-defexpr
rm -rf /opt/ceh/nixpkgs
