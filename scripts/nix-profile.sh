# Don't source anything complicated from this file, because that
# pollutes the user's environment with shell functions.  Also, since
# we're not sure that the user's shell is bash, they may not even work.
#
# Let's try to keep this file compatible with shells that are used on
# power-user desktops.  Since the user is supposed to source this in
# her .bashrc, this also should run fast (and not fork).  Currently
# tested with zsh and bash.

. /opt/ceh/lib/base.sh

[ -d $CEH_NIX ] || {
    echo >&2 "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    echo >&2 "Ceh is not properly initialized, the base package is missing:"
    echo >&2 "  $CEH_NIX"
    echo >&2 ""
    echo >&2 "If ceh is not initialized at all, you can use:"
    echo >&2 "  /opt/ceh/scripts/nix-init.sh"
    echo >&2 ""
    echo >&2 "If ceh is already installed and you got this message after a"
    echo >&2 "git pull in /opt/ceh, then most probably you have to upgrade nix:"
    echo >&2 "  /opt/ceh/scripts/nix-upgrade.sh"
    echo >&2 "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    return 1
}

ceh_path_prepend /opt/ceh/bin
ceh_path_prepend /opt/ceh/bin-user
if [[ -r /usr/lib/locale/locale-archive ]]; then
  export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
else
  export LOCPATH=/usr/lib/locale
fi
export FONTCONFIG_FILE=/etc/fonts/fonts.conf
export TZDIR=/usr/share/zoneinfo

ceh_path_prepend /opt/ceh/home/.nix-profile/share/man MANPATH
