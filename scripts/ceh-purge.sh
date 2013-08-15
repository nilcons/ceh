#!/bin/bash -ex

chmod -R +w /nix
shopt -s dotglob
rm -rf /nix/*
rm -rf ~/.nix*
