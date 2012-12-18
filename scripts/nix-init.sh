#!/bin/bash -ex

# ellenorzesek TODO(errge):
#  - locpath-ban megvannak a szukseges locale-ok

export LANG=C LC_ALL=C

if [ -e /nix ]
then
    echo "/nix exists, unsinstall first. Suggested commands:" >&2
    echo "$ sudo dpkg --purge nix" >&2
    echo "$ sudo chattr -i /nix/store" >&2
    echo "$ sudo -rf /nix" >&2
    exit 1
fi

if sudo find /root ~ -maxdepth 1 -name '.nix*' | grep -q .
then
    echo "~/.nix* or /root/.nix* found, remove them first." >&2
    exit 1
fi

if env | grep -iq ^nix_
then
    echo "Nix variables in env. Please remove those from bashrc." >&2
    echo "\"env | grep -i ^nix_\" should have no results" >&2
    exit 1
fi

if ! grep -q ^$USER: /etc/passwd
then
    echo "$USER not found in /etc/passwd . This might work to fix it:" >&2
    echo "$ getent passwd $USER" >&2
    echo "$ getent passwd $USER | sudo tee -a /etc/passwd" >&2
    exit 1
fi

cd /tmp
wget -c http://hydra.nixos.org/build/3455278/download/1/nix-1.2-i686-linux.tar.bz2
sudo bash -c "mkdir /nix && chown $USER. /nix && chmod 0700 /nix"
( cd / && tar xfj /tmp/nix-1.2-i686-linux.tar.bz2 /nix )

# Stolen from /usr/bin/nix-finish-install & /etc/profile.d/nix.sh
nix=/nix/store/rab7ylyjhc6cly6gf1h7dpybyi7z9758-nix-1.2
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

# binary-cache is only used from the root profile...
( cd /nix/var/nix/profiles/per-user ; ln -s $USER root )

    cat <<EOF
Installation finished.  To ensure that the necessary environment
variables are set, please add the lines

  source /opt/ceh/scripts/nix-profile.sh

to your shell profile (e.g. ~/.profile).
EOF
