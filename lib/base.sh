# -*- mode: shell-script; sh-basic-offset: 2; -*-

# Functions here should work in any reasonable shell, because this
# file is sourced from ceh-profile.sh.

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

ceh_check_initialization() {
    [ -x /opt/ceh/installed/essential/perl.32/bin/perl ] && \
    [ -x /opt/ceh/installed/essential/nix.32/bin/nix-env ] || {
        echo >&2 "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
        echo >&2 "Ceh is not properly initialized, the base executables are missing:"
        echo >&2 "  /opt/ceh/installed/essential/perl.32/bin/perl"
        echo >&2 "  /opt/ceh/installed/essential/nix.32/bin/nix-env"
        echo >&2 ""
        echo >&2 "This can be fixed, by running:"
        echo >&2 "  /opt/ceh/scripts/ceh-init.sh"
        echo >&2 "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
        return 1
    }
}
