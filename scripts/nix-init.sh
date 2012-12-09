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

if test -n "$(find {/root,~}  -maxdepth 1 -name '.nix*' -print)"
then
    echo "~/.nix* or /root/.nix* directories found, remove them first." >&2
    exit 1
fi

if env | grep -iq nix_
then
    echo "Nix variables in env. Please remove those from bashrc." >&2
    echo "\"env | grep -i nix_\" should have no results" >&2
    exit 1
fi

if ! grep -q ^$USER: /etc/passwd
then
    echo "$USER not found in /etc/passwd . This might work to fix it:" >&2
    echo "$ grep $USER /etc/passwd.cache" >&2
    echo "$ grep $USER /etc/passwd.cache | sudo tee -a /etc/passwd" >&2
    exit 1
fi

cd /tmp
wget -c http://hydra.nixos.org/build/2860047/download/1/nix-1.1-i686-linux.tar.bz2
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
