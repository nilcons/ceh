#!/bin/bash -e

export LANG=C LC_ALL=C

if [ ! -d /nix ]
then
  echo "/nix doesn't exist. To create it do:" >&2
  echo '$ sudo bash -c "mkdir /nix && chown $USER. /nix "' >&2
  exit 1
fi

if [ ! -O  /nix ]
then
  echo "/nix should be owned by the user. Try:" >&2
  echo "$ sudo chown $USER. /nix" >&2
  exit 1
fi

if [ -n "$(ls -A /nix)" ]
then
    echo "/nix is not empty. Try running the nix-purge.sh." >&2
    exit 1
fi

if [ "$(readlink -f /opt/ceh/home)" != "$(readlink -f $HOME)" ]
then
    echo "/opt/ceh/home should be a symlink pointing to the user's home." >&2
    echo 'Use "ln -s $HOME /opt/ceh/home" to create it.' >&2
    exit 1
fi

if find ~ -maxdepth 1 -name '.nix*' | grep -q .
then
    echo "~/.nix* found. Try running the nix-purge.sh." >&2
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

. /opt/ceh/scripts/base.sh

cd /tmp
wget -c $CEH_NIX_DOWNLOAD
chmod 0700 /nix
( cd / && tar -x --delay-directory-restore -j -f /tmp/`basename $CEH_NIX_DOWNLOAD` /nix )

# Stolen from /usr/bin/nix-finish-install & /etc/profile.d/nix.sh
regInfo=/nix/store/reginfo

$CEH_NIX/bin/nix-store --load-db < $regInfo

# Set up the symlinks
mkdir -m 0755 -p /nix/var/nix/profiles/per-user/$USER
ln -s /nix/var/nix/profiles/per-user/$USER/profile $HOME/.nix-profile
mkdir $HOME/.nix-defexpr

# Create the first user environment
$CEH_NIX/bin/nix-env -i $CEH_NIX

# Add channels
$CEH_NIX/bin/nix-channel --add http://nixos.org/releases/nixpkgs/channels/nixpkgs-unstable
$CEH_NIX/bin/nix-channel --update

# binary-cache is only used from the root profile...
( cd /nix/var/nix/profiles/per-user ; ln -s $USER root )

    cat <<EOF
Installation finished.  To ensure that the necessary environment
variables are set, please add the line

  source /opt/ceh/scripts/nix-profile.sh

to your shell profile (e.g. ~/.profile).
EOF
