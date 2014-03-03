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
            ls -lart --full-time --time=ctime /nix/store | grep '^d' | tail -n 10
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
    wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-i586.tar.gz"
    nix-store --add-fixed sha256 jdk-7u51-linux-i586.tar.gz
    wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
    nix-store --add-fixed sha256 jdk-7u51-linux-x64.tar.gz

    # Now we're using a flash player that is downloadable from adobe,
    # but this may change in the future, so leave the hack here as a
    # reference.
    # wget -c http://ftp.tw.freebsd.org/distfiles/flashplugin/11.2r202.297/install_flash_player_11_linux.i386.tar.gz
    # nix-store --add-fixed sha256 install_flash_player_11_linux.i386.tar.gz
)

# Firefox first, because mozilla CDN is sucky -> we want to fail fast
install firefox "Mozilla Firefox"

install ack "Andy Lester"
install agda "Agda version 2."
install agda-mode "Agda version 2."
install alex "Simon Marlow"
install cabal "cabal-install version"
install cabal2nix "url-to-cabal-file"
install ceh_exclude "--version is not an executable"
install cgpt "cgpt COMMAND"
install coursera-dl "usage: coursera-dl"
install cpphs "cpphs 1"
install emacs "GNU Emacs"
CEH_GHC64= install ghc "Glorious Glasgow Haskell Compilation System"
CEH_GHC64= /opt/ceh/scripts/ghc-build-shell.pl </dev/null || true
install gitceh "git version 1"
install git-annex "Usage: git-annex command"
CEH_JAVA64= CEH_JAVAFLAVOR= install javac "javac: invalid flag: --version"
CEH_JAVA64= CEH_JAVAFLAVOR=sun6 install javac  "javac: invalid flag: --version"
CEH_JAVA64= CEH_JAVAFLAVOR=sun7 install javac  "javac: invalid flag: --version"
CEH_JAVA64=1 CEH_JAVAFLAVOR= install javac "javac: invalid flag: --version"
CEH_JAVA64=1 CEH_JAVAFLAVOR=sun6 install javac "javac: invalid flag: --version"
CEH_JAVA64=1 CEH_JAVAFLAVOR=sun7 install javac "javac: invalid flag: --version"
install nc-indicators "Show CPU and MEM"
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
CEH_NO_BIN_CACHE= CEH_TWS64= CEH_TWSSUN= install tws-ui "TWS successfully installed"
CEH_NO_BIN_CACHE= CEH_TWS64= CEH_TWSSUN=1 install tws-ui "TWS successfully installed"
CEH_NO_BIN_CACHE= CEH_TWS64=1 CEH_TWSSUN= install tws-ui "TWS successfully installed"
CEH_NO_BIN_CACHE= CEH_TWS64=1 CEH_TWSSUN=1 install tws-ui "TWS successfully installed"

# very slow, so do it last to see early results from other packages.
install coqtop "Coq Proof Assistant"
