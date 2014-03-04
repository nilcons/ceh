#!/bin/bash -ex

chmod -R +w /nix
shopt -s dotglob
rm -rf /nix/*
rm -f ~/.nix-profile
rm -f ~/.nix-channels
rm -rf ~/.nix-defexpr
rm -rf /opt/ceh/nixpkgs
