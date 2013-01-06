# -*- mode: shell-script; sh-basic-offset: 2; -*-

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

# This creates a cache to make it cheaper to check if a derivation is
# installed in the current user profile.  The idea is that user
# profiles are immutable, so we can create an installed_derivations
# top-level dir in them with one file touched for each package.
# $2 is the profile path (defaults to /opt/ceh/home/.nix-profile).
ceh_nix_update_cache() {
  local profile=${1-$(readlink /opt/ceh/home/.nix-profile)}
  [ -e $profile/installed_derivations/done ] && return

  # If the profile doesn't exist, the cache can't be created.
  [ -L $profile ] || return 0

  chmod u+w $profile/
  mkdir $profile/installed_derivations
  chmod u-w $profile/
  for i in $(nix-env -p $profile --no-name --out-path -q '*'); do
    touch $profile/installed_derivations/${i#/nix/store/}
  done
  touch $profile/installed_derivations/done
}

# Checks if $1 is a nix path (/nix/store/hashxxx-pkg-0.1/whatever).  If not, returns.
# If the nix path is already installed, returns.
# Otherwise installs it with `nix-env -i'.
# $2 is the profile path (defaults to /opt/ceh/home/.nix-profile).
ceh_nix_install() {
  local profile=${2-$(readlink /opt/ceh/home/.nix-profile)}
  ceh_nix_update_cache $2

  # Start a new shell with every normal output directed to stderr, so
  # pipelines don't get confused.
  (
    exec >&2

    # This used to read "nix_real=$(readlink -f $1)", so it was
    # possible to use this function with symlinks that eventually
    # point to a nix store.  This doesn't work, because
    # e.g. ghc-7.6.1-wrapper/bin/hpc is a symlink to ghc-7.6.1/bin/hpc
    # in nix.  In that case we used to install ghc-7.6.1 instead of
    # the wrapper that the user has requested.  So if we ever want to
    # support symlinks as $1, we need a tool that canonalizes _UNTIL_
    # it reaches the first /nix/store/... path and stops there (even if
    # that is a symlink).
    local nix_real=$1
    local nix_postfix=${nix_real#/nix/store/}
    [ "$nix_postfix" = "$1" ] && return   # this is not a /nix/store path
    local nix_dir=${nix_postfix%%/*}
    [ -e $profile/installed_derivations/$nix_dir ] || {
      mkdir -p $(dirname $profile)
      nix-env -p $profile -i "/nix/store/$nix_dir"
      ceh_nix_update_cache $2
    }
  )
}

# Used to exec a command line by first installing $1.
ceh_nix_exec() {
  ceh_nix_install "$1"
  exec "$@"
}

ceh_nix_install_for_ghc() {
  ceh_nix_install $1 /nix/var/nix/profiles/ceh/ghc-libs
}

# Executes "$@" with Nix's gcc prepended to PATH and envvars hacked to
# include libs installed into the /nix/var/nix/profiles/ceh/ghc-libs profile.
ceh_gcc_wrapper_for_ghc() {
  if [ -z "$CEH_GCC_WRAPPER_FLAGS_SET" ]; then
    export NIX_LDFLAGS="-L /nix/var/nix/profiles/ceh/ghc-libs/lib $NIX_LDFLAGS"
    export NIX_CFLAGS_COMPILE="-idirafter /nix/var/nix/profiles/ceh/ghc-libs/include $NIX_CFLAGS_COMPILE"
    ceh_path_prepend "/nix/var/nix/profiles/ceh/ghc-libs/lib/pkgconfig" PKG_CONFIG_PATH || true
    ceh_nix_install /nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin
    ceh_path_prepend /nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin || {
      echo >&2 "/nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin is not installed"
      exit 1
    }

    CEH_GCC_WRAPPER_FLAGS_SET=1
  fi

  ceh_nix_exec "$@"
}
