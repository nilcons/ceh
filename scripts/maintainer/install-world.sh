#!/bin/bash -e

# This script makes sure that everything is installable that is
# currently provided by ceh.

install () {
    echo Installing $1
    /opt/ceh/bin/$1 --version >$CEH_INSTALLWORLDDIR/$1.out 2>&1 || true
    if [ "$CEH_GATHER_DERIVATIONS_ONLY" = "" ]; then
        fgrep -q -- "$2" $CEH_INSTALLWORLDDIR/$1.out
    fi
}

export CEH_INSTALLWORLDDIR=`mktemp -d /tmp/installworld.XXXXXX`
echo $CEH_INSTALLWORLDDIR

if [ "$CEH_INSTALL_WORLD_VERBOSE" != "" ]; then
    (
        set +e
        cd $CEH_INSTALLWORLDDIR
        while true ; do
            sleep 120
            echo '--------------------------------------------------------------------------------'
            date
            wc -l `ls -1rt | tail -n1`
            ls -lart --time=ctime /nix/store | grep '^d'
            echo '--------------------------------------------------------------------------------'
        done
    ) &
    trap 'kill $(jobs -p)' EXIT
fi

(
    cd /tmp
    wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-i586.bin"
    nix-store --add-fixed sha256 jdk-6u45-linux-i586.bin
    wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
    nix-store --add-fixed sha256 jdk-6u45-linux-x64.bin
)

install ack "Andy Lester"
install alex "Simon Marlow"
install cabal "cabal-install version"
install cabal2nix "url-to-cabal-file"
install ceh_exclude "--version is not an executable"
install cgpt "cgpt COMMAND"
install coursera-dl "usage: coursera-dl"
install cpphs "cpphs 1"
install emacs "GNU Emacs"
install firefox "Mozilla Firefox"
CEH_GHC64= install ghc "Glorious Glasgow Haskell Compilation System"
CEH_GHC64= /opt/ceh/scripts/ghc-build-shell.pl </dev/null || true
install gitceh "git version 1"
install git-annex "Usage: git-annex command"
install haddock "Haddock version 2"
install happy "Happy Version 1"
install hlint "Neil Mitchell"
install hp2ps "usage: hp2ps"
install hpc "Usage: hpc help"
install hsc2hs "hsc2hs version 0"
install jbig2 "jbig2enc 0.28"
install patchelf "patchelf 0"
install parallel "O. Tange"
install python3 "Python 3"
install tmux "usage: tmux"
install vanitygen "Generates a bitcoin"
install vbutil_kernel "This program creates, signs"
install xpra "xpra v0."

# Needs investigation: doesn't compile from source, because gcc doesn't compile in 64-bit mode.
# Binary cache installation is OK.
CEH_NO_BIN_CACHE= CEH_GHC64=1 install ghc "Glorious Glasgow Haskell Compilation System"
CEH_NO_BIN_CACHE= CEH_GHC64=1 /opt/ceh/scripts/ghc-build-shell.pl </dev/null || true

# Needs investigation: doesn't compile from source, because openjdk doesn't compile.
# Binary cache installation is OK.
CEH_NO_BIN_CACHE= install adb "Android Debug Bridge"
CEH_NO_BIN_CACHE= install tws-ui "TWS"
CEH_NO_BIN_CACHE= CEH_TWSSUN=1 install tws-ui "TWS"
CEH_NO_BIN_CACHE= CEH_TWS64=1 install tws-ui "TWS"
CEH_NO_BIN_CACHE= CEH_TWS64=1 CEH_TWSSUN=1 install tws-ui "TWS"

# very slow, so do it last to see early results from other packages.
install coqtop "Coq Proof Assistant"
