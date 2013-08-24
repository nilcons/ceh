# -*- mode: shell-script; sh-basic-offset: 2; -*-

# Functions here should work in any reasonable shell, because this
# file is sourced from ceh-profile.sh.

# TODO(errge): document that this is shared between perl and shell
export CEH_NIX_DOWNLOAD=http://hydra.nixos.org/build/5775984/download/1/nix-1.6pre3194_03eaef3-i686-linux.tar.bz2
export CEH_NIX=/nix/store/0dc80pah55lqawxn5baml2lsj2q3qilz-nix-1.6pre3194_03eaef3

# Prepends $1 to the front of $2 (which should be a colon separated
# list).  If $1 is already contained in $2, deletes the old occurrence
# first.  $2 defaults to PATH.  No-op if $1 is not a directory.
ceh_path_prepend() {
    new=$1
    list=${2-PATH}
    [ -d "$new" ] || return
    eval "local fenced=:\$$list:"
    local removed=${fenced/:$1:/:}
    local trimleft=${removed#:}
    local trimright=${trimleft%:}
    export $list=$new:$trimright
}

