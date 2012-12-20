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

# Executes "$@" with Nix's gcc prepended to PATH and envvars hacked to
# include libs installed to ~/.nix-profile.
ceh_gcc_wrapper() {
    if [ -z "$CEH_GCC_WRAPPER_FLAGS_SET" ]; then
	export NIX_LDFLAGS="-L /opt/ceh/home/.nix-profile/lib $NIX_LDFLAGS"
	export NIX_CFLAGS_COMPILE="-idirafter /opt/ceh/home/.nix-profile/include $NIX_CFLAGS_COMPILE"
	ceh_path_prepend "/opt/ceh/home/.nix-profile/lib/pkgconfig" PKG_CONFIG_PATH
	ceh_path_prepend /nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin

	CEH_GCC_WRAPPER_FLAGS_SET=1
    fi

    exec "$@"
}
