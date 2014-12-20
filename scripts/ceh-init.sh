#!/bin/sh

set -e

export CEH_NIX_DOWNLOAD=http://hydra.nixos.org/build/17897582/download/1/nix-1.8-i686-linux.tar.bz2
export NIX_TARDIR_NAME=nix-1.8-i686-linux
export CEH_NIX=/nix/store/a1kr8kds4jdvvfl6z4gj0gr9w27awhnd-nix-1.8

export LANG=C LC_ALL=C

if [ "$(id -u)" = 0 ] || [ "$(id -ru)" = 0 ] || [ "$USER" = root ]
then
  echo >&2 "This script should be used as the user who wants to install Ceh, not as root."
  exit 1
fi

if [ -z "$USER" ] || [ -z "$HOME" ]
then
  echo >&2 "USER or HOME envvar is undefined."
  exit 1
fi

if [ -e "/run/current-system" ]
then
  echo "We're running on NixOS, you're very cool!"
  echo
  alias nixosp=true
else
  alias nixosp=false
fi

if ! wget --version >/dev/null 2>&1 && ! nixosp
then
  echo "wget is needed for installation" >&2
  exit 1
fi

if ! mktemp --version >/dev/null 2>&1 && ! nixosp
then
  echo "mktemp is needed for installation" >&2
  exit 1
fi

if ! bzip2 --help >/dev/null 2>&1 && ! nixosp
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
  if nixosp
  then
    echo >&2 "No /nix on NixOS, wtf?"
    exit 1
  else
    echo "/nix doesn't exist. To create it do:" >&2
    echo '$ sudo bash -c "mkdir /nix && chown $USER. /nix "' >&2
    exit 1
  fi
fi

if ! [ -O /nix ] && ! nixosp
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

# Travis has some strange buggy kernel
# https://bugs.launchpad.net/ubuntu/+source/bash/+bug/452175
if [ "$TRAVIS_BUILD_DIR" != "" ]
then
    sudo bash -c "echo 0 > /proc/sys/kernel/randomize_va_space"
    echo "check_certificate = off" >~/.wgetrc
fi

if ! nixosp
then
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

  TDIR=$(mktemp -d)
  cd $TDIR
  wget -c $CEH_NIX_DOWNLOAD
  tar xfj `basename $CEH_NIX_DOWNLOAD`
  chmod 0700 /nix
  # We have to give write access to the stuff that we want to overwrite
  # in the nix store, but we don't want to touch symlinks, since when
  # they're dangling, chmod freaks out.  Also, we don't want to chmod
  # non-preexisting stuff, so we filter for directory or regular file.
  ( cd $NIX_TARDIR_NAME && find store ) | ( cd /nix ;
      while read F; do
        if [ -f "$F" -o -d "$F" ]; then
          echo "$F"
        fi
      done | xargs --no-run-if-empty chmod u+w )
  ( cd $NIX_TARDIR_NAME && cp -a store /nix )

  # Set up the symlinks
  mkdir -m 0755 -p /nix/var/nix/gcroots/auto/ceh
  mkdir -m 0755 -p /nix/var/nix/profiles/per-user/$USER
  ln -s /nix/var/nix/profiles/per-user/$USER/profile $HOME/.nix-profile
  ( cd /nix/var/nix/profiles/per-user ; ln -s $USER root )
  mkdir -p $HOME/.nix-defexpr

  # Initialize the nix store
  $CEH_NIX/bin/nix-store --load-db < $NIX_TARDIR_NAME/.reginfo

  # This also initializes the nixpkgs git repo in /opt/ceh/nixpkgs.
  ENSURE_BASE_PERL=/nix/store/p0kbl09j5q88d9i96ap4arffsd5ybjwx-perl-5.20.1/bin/perl \
    ENSURE_BASE_NIXPATH=/nix/store/a1kr8kds4jdvvfl6z4gj0gr9w27awhnd-nix-1.8 \
    /opt/ceh/lib/ensure_base_installed.pl

  # Add channels
  /opt/ceh/bin/nix-channel --add http://nixos.org/channels/nixpkgs-unstable
  /opt/ceh/bin/nix-channel --update
else
  # if we're on NixOS
  if ! [ -d /nix/var/nix/gcroots/auto/ceh ] || ! [ -O /nix/var/nix/gcroots/auto/ceh ]
  then
    echo "/nix/var/nix/gcroots/auto/ceh directory should be owned by the user. Try:" >&2
    echo "$ sudo mkdir -p /nix/var/nix/gcroots/auto/ceh" >&2
    echo "$ sudo chown $USER. /nix/var/nix/gcroots/auto/ceh" >&2
    exit 1
  fi

  # This also initializes the nixpkgs git repo in /opt/ceh/nixpkgs.
  ENSURE_BASE_PERL=/run/current-system/sw/bin/perl \
    ENSURE_BASE_NIXPATH=/run/current-system/sw \
    /opt/ceh/lib/ensure_base_installed.pl
fi

cat <<EOF



Installation finished.  To ensure that the necessary environment
variables are set, please add the line

  source /opt/ceh/scripts/ceh-profile.sh

to your shell profile (e.g. ~/.profile).
EOF
