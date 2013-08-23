#!/bin/bash -e

export LANG=C LC_ALL=C

if ! wget --version >/dev/null 2>&1
then
  echo "wget is needed for installation" >&2
  exit 1
fi

if ! bzip2 --version >/dev/null 2>&1
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

if [ -n "$(ls -A /nix)" ]
then
    echo "/nix is not empty. Try running the ceh-purge.sh." >&2
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
    echo "~/.nix* found. Try running the ceh-purge.sh." >&2
    exit 1
fi

if env | grep -v ^NIX_CONF_DIR | grep -iq ^nix_
then
    echo "Nix variables in env. Please remove those from bashrc." >&2
    echo "\"env | grep -v ^NIX_CONF_DIR | grep -i ^nix_\" should have no results" >&2
    exit 1
fi

if ! grep -q ^$USER: /etc/passwd
then
    echo "$USER not found in /etc/passwd . This might work to fix it:" >&2
    echo "$ getent passwd $USER" >&2
    echo "$ getent passwd $USER | sudo tee -a /etc/passwd" >&2
    exit 1
fi

. /opt/ceh/lib/base.sh

cd /tmp
wget -c $CEH_NIX_DOWNLOAD
chmod 0700 /nix
( cd / && tar -x --delay-directory-restore -j -f /tmp/`basename $CEH_NIX_DOWNLOAD` /nix )

# Travis needs some help...
# This can be removed when nix 1.6 is released
if [ "$TRAVIS_BUILD_DIR" != "" ]
then
    (
        cd /tmp
        git clone git://github.com/errge/glibc-bin-for-ceh
        cd glibc-bin-for-ceh
        mkdir x
        cd x
        tar xfz ../6svswqi259sv26xda2rm5h9iry6q9k5k-glibc-2.17.tgz
        sudo rm -rf /nix/store/yivvs4w7qhj3yysvxvfwzzfspr4yzd38-glibc-2.17
        mkdir /nix/store/yivvs4w7qhj3yysvxvfwzzfspr4yzd38-glibc-2.17
        cp -a * /nix/store/yivvs4w7qhj3yysvxvfwzzfspr4yzd38-glibc-2.17
        cd /nix/store
        ln -s /nix/store/yivvs4w7qhj3yysvxvfwzzfspr4yzd38-glibc-2.17 /nix/store/6svswqi259sv26xda2rm5h9iry6q9k5k-glibc-2.17
    )
fi

# Stolen from /usr/bin/nix-finish-install & /etc/profile.d/nix.sh
regInfo=/nix/store/reginfo

$CEH_NIX/bin/nix-store --load-db < $regInfo

# Set up the symlinks
mkdir -m 0755 -p /nix/var/nix/profiles/ceh
mkdir -m 0755 -p /nix/var/nix/profiles/per-user/$USER
ln -s /nix/var/nix/profiles/per-user/$USER/profile $HOME/.nix-profile
( cd /nix/var/nix/profiles/per-user ; ln -s $USER root )
mkdir $HOME/.nix-defexpr

# Test that on-demand installation works
/opt/ceh/bin/nix-env --version

# Add channels
$CEH_NIX/bin/nix-channel --add http://nixos.org/releases/nixpkgs/channels/nixpkgs-unstable
$CEH_NIX/bin/nix-channel --update

# TODO(errge): reimplement this whole script in perl, and then we can share
# common variables, like CEH_NIXPKGS_GITURL and CEH_NIXPKGS_GIT
echo "Checking out nixpkgs..."
mkdir -p /nix/var/ceh_nixpkgs/git
/usr/bin/git clone --bare http://github.com/NixOS/nixpkgs /nix/var/ceh_nixpkgs/git
touch /nix/var/ceh_nixpkgs/git.done

    cat <<EOF
Installation finished.  To ensure that the necessary environment
variables are set, please add the line

  source /opt/ceh/scripts/ceh-profile.sh

to your shell profile (e.g. ~/.profile).
EOF
