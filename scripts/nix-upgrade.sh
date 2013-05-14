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

if [ "$(readlink -f /opt/ceh/home)" != "$(readlink -f $HOME)" ]
then
    echo "/opt/ceh/home should be a symlink pointing to the user's home." >&2
    echo 'Use "ln -s $HOME /opt/ceh/home" to create it.' >&2
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

if [ -d $CEH_NIX ] && [ -f /opt/ceh/home/.nix-profile/installed_derivations/`basename $CEH_NIX` ]
then
    echo >&2 "Nix store already has the current nix version:"
    echo >&2 "  $CEH_NIX"
    echo >&2 "  /opt/ceh/home/.nix-profile/installed_derivations/`basename $CEH_NIX`"
    exit 1
fi

echo >&2 Checks OK, upgrading to `basename $CEH_NIX`

cd /tmp
wget -c $CEH_NIX_DOWNLOAD
( cd / && tar -x -k --delay-directory-restore -j -f /tmp/`basename $CEH_NIX_DOWNLOAD` /nix/store )
( cd / && tar -x --overwrite --delay-directory-restore -j -f /tmp/`basename $CEH_NIX_DOWNLOAD` /nix/store/reginfo )
$CEH_NIX/bin/nix-store --load-db < /nix/store/reginfo
$CEH_NIX/bin/nix-env -i $CEH_NIX

. /opt/ceh/scripts/common-functions.sh
ceh_nix_update_cache

if [ -d $CEH_NIX ] && [ -f /opt/ceh/home/.nix-profile/installed_derivations/`basename $CEH_NIX` ]
then
    echo >&2 "Upgrade succeeded:"
    echo >&2 "  $CEH_NIX"
    echo >&2 "  /opt/ceh/home/.nix-profile/installed_derivations/`basename $CEH_NIX`"
    exit 0
else
    echo >&2 "Upgrade failed."
    exit 1
fi
