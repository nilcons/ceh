# -*- mode: shell-script; sh-basic-offset: 2; -*-

# Functions here should work in any reasonable shell, because this
# file is sourced from nix-profile.sh.

export CEH_NIX_DOWNLOAD=http://hydra.nixos.org/build/4253993/download/1/nix-1.5.1-i686-linux.tar.bz2
export CEH_NIX=/nix/store/k0ksg8yjwz026vwivcnkjwfmv4jbkqyl-nix-1.5.1

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

