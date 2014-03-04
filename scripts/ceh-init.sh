#!/bin/bash

set -e
set -o pipefail

export CEH_NIX_DOWNLOAD=http://hydra.nixos.org/build/6695693/download/1/nix-1.6.1-i686-linux.tar.bz2

export LANG=C LC_ALL=C

if ! wget --version >/dev/null 2>&1
then
  echo "wget is needed for installation" >&2
  exit 1
fi

if ! bzip2 --help >/dev/null 2>&1
then
  echo "bzip2 is needed for installation" >&2
  exit 1
fi

if ! git --version >/dev/null 2>&1
then
  echo "git is needed for installation" >&2
  exit 1
fi

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

if [ "$(readlink -f /opt/ceh/home)" != "$(readlink -f $HOME)" ]
then
    echo "/opt/ceh/home should be a symlink pointing to the user's home." >&2
    echo 'Use "ln -s $HOME /opt/ceh/home" to create it.' >&2
    exit 1
fi

if ! grep -q ^$USER: /etc/passwd
then
    echo "$USER not found in /etc/passwd . This might work to fix it:" >&2
    echo "$ getent passwd $USER" >&2
    echo "$ getent passwd $USER | sudo tee -a /etc/passwd" >&2
    exit 1
fi

if [ -L $HOME/.nix-profile ]
then
    rm -f $HOME/.nix-profile
fi

if [ -e $HOME/.nix-profile ]
then
    echo "$HOME/.nix-profile exists and it's not a (removable) symlink." >&2
    echo "Use ceh-purge.sh to clean it!" >&2
    exit 1
fi

if [ -L /nix/var/nix/profiles/per-user/root ]
then
    rm -f /nix/var/nix/profiles/per-user/root
fi

if [ -e /nix/var/nix/profiles/per-user/root ]
then
    echo "/nix/var/nix/profiles/per-user/root is not a (removable) symlink." >&2
    echo "This is inconsistent with Ceh, please clean it up." >&2
    exit 1
fi

. /opt/ceh/lib/base.sh

# Travis has some strange buggy kernel
# https://bugs.launchpad.net/ubuntu/+source/bash/+bug/452175
if [ "$TRAVIS_BUILD_DIR" != "" ]
then
    sudo bash -c "echo 0 > /proc/sys/kernel/randomize_va_space"
    echo "check_certificate = off" >~/.wgetrc
fi

cd /tmp
wget -c $CEH_NIX_DOWNLOAD
chmod 0700 /nix
# We have to give write access to the stuff that we want to overwrite
# in the nix store, but we don't want to touch symlinks, since when
# they're dangling, chmod freaks out.  Also, we don't want to chmod
# non-preexisting stuff, so we filter for directory or regular file.
( cd / && tar -t -j -f /tmp/`basename $CEH_NIX_DOWNLOAD` /nix | (
        while read F; do
            if [[ -f "$F" || -d "$F" ]]; then
                echo "$F"
            fi
        done
    ) | xargs --no-run-if-empty chmod u+w)
( cd / && tar -x -j -f /tmp/`basename $CEH_NIX_DOWNLOAD` /nix )

# Set up the symlinks
mkdir -m 0755 -p /nix/var/nix/profiles/ceh
mkdir -m 0755 -p /nix/var/nix/profiles/per-user/$USER
ln -s /nix/var/nix/profiles/per-user/$USER/profile $HOME/.nix-profile
( cd /nix/var/nix/profiles/per-user ; ln -s $USER root )
mkdir -p $HOME/.nix-defexpr

# This also initializes the nixpkgs git repo in /opt/ceh/nixpkgs.
ENSURE_BASE_PERL=/nix/store/x39yy4fg60qqgdrjhbwzrjs8r7w5wmzy-perl-5.16.3/bin/perl \
ENSURE_BASE_NIXPATH=/nix/store/z2khn1qwap8lmxgg9iyvljcnrw6vi8zr-nix-1.6.1 \
  /opt/ceh/lib/ensure_base_installed.pl

# Add channels
/opt/ceh/bin/nix-channel --add http://nixos.org/channels/nixpkgs-unstable
/opt/ceh/bin/nix-channel --update

    cat <<EOF



Installation finished.  To ensure that the necessary environment
variables are set, please add the line

  source /opt/ceh/scripts/ceh-profile.sh

to your shell profile (e.g. ~/.profile).
EOF
