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

if [ "$(readlink -f /opt/ceh/home)" != "$(readlink -f $HOME)" ]
then
    echo "/opt/ceh/home should be a symlink pointing to the user's home." >&2
    echo 'Use "ln -s $HOME /opt/ceh/home" to create it.' >&2
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

if [ -d $CEH_NIX ] && [ -f /nix/var/nix/profiles/ceh/bin/installed_derivations/`basename $CEH_NIX` ]
then
    echo >&2 "Nix store already has the current nix version:"
    echo >&2 "  $CEH_NIX"
    echo >&2 "  /nix/var/nix/profiles/ceh/bin/installed_derivations/`basename $CEH_NIX`"
    exit 1
fi

echo >&2 Checks OK, upgrading to `basename $CEH_NIX`

cd /tmp
wget -c $CEH_NIX_DOWNLOAD
# ---------- this is a bit hacky, but --skip-old-files is very new in gnutar :-(
bzcat /tmp/`basename $CEH_NIX_DOWNLOAD` >/tmp/`basename $CEH_NIX_DOWNLOAD .bz2`
SHOULDHAVE=$(tar tf /tmp/`basename $CEH_NIX_DOWNLOAD .bz2`  | grep '^/nix/store/' | cut -d/ -f-4 | sort | uniq | grep -v '/nix/store/reginfo')
needed="/nix/store/reginfo"
for i in  $SHOULDHAVE; do
    if [ -e $i ]; then
        :
    else
        needed="$needed $i"
    fi
done
rm -f /nix/store/reginfo
( cd / && tar -x --overwrite -f /tmp/`basename $CEH_NIX_DOWNLOAD .bz2` $needed )
# ---------- end of the hack
$CEH_NIX/bin/nix-store --load-db < /nix/store/reginfo
/opt/ceh/bin/nix-env --version

if [ -d $CEH_NIX ] && [ -f /nix/var/nix/profiles/ceh/bin/installed_derivations/`basename $CEH_NIX` ]
then
    echo >&2 "Upgrade succeeded:"
    echo >&2 "  $CEH_NIX"
    echo >&2 "  /nix/var/nix/profiles/ceh/bin/installed_derivations/`basename $CEH_NIX`"
    exit 0
else
    echo >&2 "Upgrade failed."
    exit 1
fi
