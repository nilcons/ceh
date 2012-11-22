#!/bin/bash -e

# PREREQ: /nix nem letezik
# PREREQ: ~/.nix-* nem letezik

export LANG=C

cd /tmp
wget http://hydra.nixos.org/build/2860047/download/1/nix-1.1-i686-linux.tar.bz2
sudo bash -c "mkdir /nix && chown $USER. /nix && chmod 0700 /nix"
( cd / && tar xfj /tmp/nix-1.1-i686-linux.tar.bz2 /nix )

# Stolen from /usr/bin/nix-finish-install & /etc/profile.d/nix.sh
nix=/nix/store/j2310a3rankswi9g8gwx2lh0yjmdy1bg-nix-1.1
regInfo=/nix/store/reginfo

$nix/bin/nix-store --load-db < $regInfo

# Set up the symlinks
mkdir -m 0755 -p /nix/var/nix/profiles/per-user/$USER
ln -s /nix/var/nix/profiles/per-user/$USER/profile $HOME/.nix-profile
mkdir -m 0755 -p /nix/var/nix/gcroots/per-user/$USER
mkdir $HOME/.nix-defexpr

# Create the first user environment
$nix/bin/nix-env -i $nix

# Add channels
$nix/bin/nix-channel --add http://nixos.org/releases/nixpkgs/channels/nixpkgs-unstable
$nix/bin/nix-channel --update

    cat <<EOF
Installation finished.  To ensure that the necessary environment
variables are set, please add the lines

  export PATH=/opt/ceh/bin:\$PATH
  export LOCPATH=/usr/lib/locale
  export FONTCONFIG_FILE=/etc/fonts/fonts.conf

to your shell profile (e.g. ~/.profile).
EOF
