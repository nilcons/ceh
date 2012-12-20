. /opt/ceh/scripts/common-functions.sh

ceh_path_prepend /opt/ceh/bin
export LOCPATH=/usr/lib/locale
export FONTCONFIG_FILE=/etc/fonts/fonts.conf

# or do we want to manage our own man symlinks independently from
# nix-env like we do for bin?
ceh_path_prepend /opt/ceh/home/.nix-profile/share/man MANPATH
