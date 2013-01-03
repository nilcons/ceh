# Please note that these functions only work in bash, not in dash,
# so in shell scripts that use these functions, you have to use
# #!/bin/bash as the she-bang line, not #!/bin/sh.

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

# Checks if $1 is a nix path (/nix/store/whatever/*).  If not, returns.
# If the nix path is already installed, returns.
# Otherwise installs it with `nix-env -i'.
ceh_nix_install() {
  # Start a new shell with every normal output directed to stderr, so
  # pipelines don't get confused.
  (
    exec >&2

    local nix_postfix=${1#/nix/store/}
    [ "$nix_postfix" = "$1" ] && return   # this is not a /nix/store path
    local nix_dir=${nix_postfix%%/*}
    [ -d "/nix/store/$nix_dir" ] || nix-env -i "/nix/store/$nix_dir"
  )
}

# Used to exec a command line by first installing $1.
ceh_nix_exec() {
  ceh_nix_install "$1"
  exec "$@"
}

# Executes "$@" with Nix's gcc prepended to PATH and envvars hacked to
# include libs installed to ~/.nix-profile.
ceh_gcc_wrapper() {
  if [ -z "$CEH_GCC_WRAPPER_FLAGS_SET" ]; then
    export NIX_LDFLAGS="-L /opt/ceh/home/.nix-profile/lib $NIX_LDFLAGS"
    export NIX_CFLAGS_COMPILE="-idirafter /opt/ceh/home/.nix-profile/include $NIX_CFLAGS_COMPILE"
    ceh_path_prepend "/opt/ceh/home/.nix-profile/lib/pkgconfig" PKG_CONFIG_PATH || true
    ceh_nix_install /nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin
    ceh_path_prepend /nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin || {
      echo >&2 "/nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin is not installed"
      exit 1
    }

    CEH_GCC_WRAPPER_FLAGS_SET=1
  fi

  ceh_nix_exec "$@"
}
