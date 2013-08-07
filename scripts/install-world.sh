#!/bin/bash -e

# This script makes sure that everything is installable that is
# currently provided by ceh.

install () {
    echo Installing $1
    /opt/ceh/bin/$1 --version >$CEH_INSTALLWORLDDIR/$1.stdout 2>$CEH_INSTALLWORLDDIR/$1.stderr || true
    if [ "$CEH_GATHER_DERIVATIONS_ONLY" != "1" ]; then
	fgrep -q "$2" $CEH_INSTALLWORLDDIR/$1.{stdout,stderr}
    fi
}

export CEH_INSTALLWORLDDIR=`mktemp -d /tmp/installworld.XXXXXX`
echo $CEH_INSTALLWORLDDIR

install ack "Andy Lester"
install adb "Android Debug Bridge"
install alex "Simon Marlow"
install cabal "cabal-install version"
install cabal2nix "url-to-cabal-file"
install cgpt "cgpt COMMAND"
install coqtop "Coq Proof Assistant"
install coursera-dl "usage: coursera-dl"
install cpphs "cpphs 1"
install emacs "GNU Emacs"
install firefox "Mozilla Firefox"
install ghc "Glorious Glasgow Haskell Compilation System"
install git "git version 1"
install git-annex "Usage: git-annex command"
install haddock "Haddock version 2"
install happy "Happy Version 1"
install hlint "Neil Mitchell"
install hp2ps "usage: hp2ps"
install hpc "Usage: hpc help"
install hsc2hs "hsc2hs version 0"
install jbig2 "jbig2enc 0.28"
install patchelf "patchelf 0"
install python3 "Python 3"
install tmux "usage: tmux"
install tws-ui "TWS"
install vanitygen "Generates a bitcoin"
install vbutil_kernel "This program creates, signs"
install xpra "xpra v0."
