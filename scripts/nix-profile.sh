export PATH=/opt/ceh/bin:$PATH
export LOCPATH=/usr/lib/locale
export FONTCONFIG_FILE=/etc/fonts/fonts.conf

# or do we want to manage our own man symlinks independently from
# nix-env like we do for bin?
export MANPATH=/opt/ceh/home/.nix-profile/share/man:$MANPATH
