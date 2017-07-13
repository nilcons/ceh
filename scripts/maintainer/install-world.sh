#!/bin/bash

set -e

# This script makes sure that everything is installable that is
# currently provided by ceh.

# We call this function curl, so that the user can just grep in this
# file to find out how to automatically download Oracle stuff.
curl () {
    # Enforce at least 500 kbits/sec, travis <-> oracle conn randomness.
    # We do a while loop instead of using curl's retry mechanism,
    # because curl truncates back the output file to the beginning
    # size on every retry (wtf!).
    while ! /usr/bin/curl -C - -y 10 -Y 500000 "$@" ; do
        sleep 1
    done
}

install () {
    tries=1
    touch $CEH_INSTALLWORLDDIR/$1.out
    while true; do
        if [ "$tries" -gt 1 ]; then
            echo "------------------------------------------------------------------------"
            echo "Installation of $1 failed (last 100 output lines)":
            tail -n 100 $CEH_INSTALLWORLDDIR/$1.out
            echo "-- Current processes:"
            ps auxwf
            echo "-- free:"
            free
            echo "-- df:"
            df
            echo "-- dmesg:"
            sudo dmesg -c
            echo "-- ipcs:"
            ipcs
            ipcs p
            echo "-- /proc/meminfo:"
            cat /proc/meminfo
            echo "-- /proc/user_beancounters"
            cat /proc/user_beancounters || true
            echo "-- smem:"
            smem -tw || true
            smem || true
            echo "Sleeping for 30 seconds in the hopes of the problem going away"
            sleep 30
            echo "------------------------------------------------------------------------"
            if [ "$tries" -gt 10 ]; then
                echo Failed for 10 times, giving up...
                exit 1
            fi
            echo TRY $tries of installing $1 at $(date)
        else
            echo Installing $1 at $(date)
        fi

        date1=$(date +"%s")
        /opt/ceh/bin/$1 --version >$CEH_INSTALLWORLDDIR/$1.out 2>&1 || true
        if [ "$CEH_GATHER_DERIVATIONS_ONLY" != "" ]; then
            # just gathering derivations, no need to check version string
            break
        fi
        if fgrep -q -- "$2" $CEH_INSTALLWORLDDIR/$1.out; then
            # installation succeeded and we have found the version string
            date2=$(date +"%s")
            diff=$(($date2-$date1))
            echo "FINISHED $1 at $(date): $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
            break
        fi
        tries=$((tries+1))
    done
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

    curl -L -o jdk-8u131-linux-x64.tar.gz -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz &
    wait

    nix-store --add-fixed sha256 jdk-8u131-linux-x64.tar.gz

    # Now we're using a flash player that is downloadable from adobe,
    # but this may change in the future, so leave the hack here as a
    # reference.
    # wget -c http://ftp.tw.freebsd.org/distfiles/flashplugin/11.2r202.297/install_flash_player_11_linux.i386.tar.gz
    # nix-store --add-fixed sha256 install_flash_player_11_linux.i386.tar.gz

) & # we are starting this in the background, because it is slow and
    # we will do a wait later before actually using the java.
JAVA_DOWNLOADS_PID=$!

# Let's don't depend on X.
export DISPLAY=

install ack "Andy Lester"
install agda "Agda version 2."
install agda-mode "Agda version 2."
install alex "Simon Marlow"
install cabal "cabal-install version"
install cabal2nix "1."
install ceh_exclude "--version is not an executable"
install cgpt "cgpt COMMAND"
install coqtop "Coq Proof Assistant"
install coursera-dl "usage: coursera-dl"
install cpphs "cpphs 1"
install emacs "GNU Emacs"
CEH_GHC32= install ghc "Glorious Glasgow Haskell Compilation System"
CEH_GHC32= /opt/ceh/scripts/ghc-build-shell.pl </dev/null || true
install gitceh "git version 2"
install git-annex "Usage: git-annex command"
install nc-indicators "nc-indicators: Cannot initialize GUI."
install haddock "Haddock version 2"
install happy "Happy Version 1"
install hlint "Neil Mitchell"
install hp2ps "usage: hp2ps"
install hpc "Usage: hpc help"
install hsc2hs "hsc2hs version 0"
install jbig2 "jbig2enc 0.28"
install nix-repl "nix-repl"
install nix-prefetch-git "Initialized empty Git repository"
install pandoc "Syntax highlighting is supported for the following"
install patchelf "patchelf 0"
install parallel "O. Tange"
install tmux "usage: tmux"
install vanitygen "Generates a bitcoin"
install vbutil_kernel "This program creates, signs"
install vncviewer "TigerVNC Viewer 64-bit"
install xpra "xpra v0."

CEH_GHC32=1 install ghc "Glorious Glasgow Haskell Compilation System"
CEH_GHC32=1 /opt/ceh/scripts/ghc-build-shell.pl </dev/null || true

install adb "Android Debug Bridge"

# Everything that depends on java is done below this comment and we
# start with a wait for the background downloads to finish.
echo Waiting for the java downloads to finish at $(date)
wait $JAVA_DOWNLOADS_PID
echo Java downloads finished at $(date)
CEH_JAVAFLAVOR= install javac "javac: invalid flag: --version"
CEH_JAVAFLAVOR=sun8 install javac  "javac: invalid flag: --version"
install firefox "Mozilla Firefox"
install tws-ui "TWS successfully installed"
