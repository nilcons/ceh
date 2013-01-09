. /opt/ceh/scripts/common-functions.sh

ceh_path_prepend /opt/ceh/bin
if [[ -r /usr/lib/locale/locale-archive ]]; then
  export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
else
  export LOCPATH=/usr/lib/locale
fi
export FONTCONFIG_FILE=/etc/fonts/fonts.conf

# or do we want to manage our own man symlinks independently from
# nix-env like we do for bin?
ceh_path_prepend /opt/ceh/home/.nix-profile/share/man MANPATH
