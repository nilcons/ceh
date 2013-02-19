# -*- mode: shell-script; sh-basic-offset: 2; -*-

# Please note that these functions only work in bash, not in dash,
# so in shell scripts that use these functions, you have to use
# #!/bin/bash as the she-bang line, not #!/bin/sh.

export CEH_NIX=/nix/store/rab7ylyjhc6cly6gf1h7dpybyi7z9758-nix-1.2

# This creates a cache to make it cheaper to check if a derivation is
# installed in a profile.  The idea is that profiles are immutable, so
# we can create an installed_derivations top-level dir in them with
# one file touched for each package.
#
# $1 is the profile path (defaults to /opt/ceh/home/.nix-profile).
ceh_nix_update_cache() {
  local profile=${1-$(readlink /opt/ceh/home/.nix-profile)}
  [ -e $profile/installed_derivations/done ] && return 0

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

# Downloads and initializes a specific nixpkgs version into the
# /nix/var/nix/profiles/ceh/nixpkgs profile, so it can be used for
# builds later.
#
# This is needed instead of simply using channels and the newest
# version only, because we want to reproduce specific blessed versions
# of binaries and not the newest version in nixpkgs.
#
# $1: the nixpkgs version to initialize, e.g. 1.0pre23266_7e1d0c1
#
# It sets NIX_PATH up, so '<ceh_nixpkgs>' points to the initialized
# version in nix commands.
ceh_nixpkgs_init_version () {
  local version=$1

  # we say that everything is version 1.0, so we can have multiple
  # versions of different nixpkgs; usual Debian trick: version is part
  # of the package name :)
  local cname=ceh_nixpkgs_$version-1.0
  local nixpkgs=/nix/var/nix/profiles/ceh/nixpkgs/$cname

  [ -L $nixpkgs ] || {
    mkdir -p /nix/var/nix/profiles/ceh
    if [[ "$version" =~ ^1.0pre[0-9]*_([0-9a-f]*)$ ]]; then
      # Standard nixpkgs 1.0pre release from git, let's use github
      # instead, so we don't depend on nixos.org/releases being
      # available and on "obsolete" stuff not being deleted.
      local githash=${BASH_REMATCH[1]}

      local gzpath=$(CURL_CA_BUNDLE=/opt/ceh/ca-bundle.crt PRINT_PATH=1 $CEH_NIX/bin/nix-prefetch-url "https://github.com/NixOS/nixpkgs/archive/$githash.tar.gz" | tail -n +2)
      local bzpath=${gzpath%.gz}.bz2
      zcat $gzpath | bzip2 -1zc >$bzpath
      local path=$(PRINT_PATH=1 $CEH_NIX/bin/nix-prefetch-url "file://$bzpath" | tail -n +2)
    else
      local path=$(PRINT_PATH=1 $CEH_NIX/bin/nix-prefetch-url "http://nixos.org/releases/nixpkgs/nixpkgs-$version/nixexprs.tar.bz2" | tail -n +2)
      if [[ -z $path ]]; then
	path=$(PRINT_PATH=1 $CEH_NIX/bin/nix-prefetch-url "http://nixos.org/releases/nixpkgs/nixpkgs-$version/nixexprs.tar.xz" | tail -n +2)
      fi
    fi
    $CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/nixpkgs -f '<nix/unpack-channel.nix>' -i \
      -E "f: f { name = \"$cname\"; channelName = \"$cname\"; src = builtins.storePath \"$path\"; binaryCacheURL = \"http://nixos.org/binary-cache/\"; }"
  }

  export NIX_PATH=ceh_nixpkgs=$nixpkgs
}

# Used in wrapper scripts in bin/*.
#
# If $1 is an already installed package, returns immediately.
# Otherwise builds and installs it.  In case of success, sets
# ceh_nix_install_root to /nix/store/$4, so you don't have to repeat
# yourself in wrapper scripts.
#
# Nix internally uses a binary cache, so may not necessarily build.
#
# To identify a package to install, you have to specify:
#   - $1: package name (attribute path),
#   - $2: nixpkgs version the package is specified in,
#   - $3: the derivation produced in /nix/store,
#   - $4: the output path in /nix/store.
#
# $3 and $4 is a function of $1 and $2; you only need specify them, so
# we can verify and rest assured that everything went correctly.
#
# Although all the four arguments are mandatory, the last three is
# optional in a sense.  If you run the function with less than 4
# arguments, it will figure out the next and print you the correct
# command line to use.  This is an easy way to write new wrapper
# scripts.
#
# $5 is an optional target profile (defaults to /opt/ceh/home/.nix-profile).
ceh_nixpkgs_install () {
  local pkgattr=$1
  local nixpkgs_version=$2
  local derivation=$3
  local out=$4
  local profile=${5-$(readlink /opt/ceh/home/.nix-profile)}
  ceh_nix_update_cache $profile

  # Start a new shell with every normal output directed to stderr, so
  # pipelines don't get confused.
  (
    exec >&2

    # quick return if the package is already installed in the profile
    if [ -n "$out" ]; then
      if [ -e $profile/installed_derivations/$out ]; then
	return 0
      fi
    fi

    [ -n "$pkgattr" ] || {
      echo >&2 "ceh_nixpkgs_install called without package attr path"
      echo >&2 "use 'nix-env -qaP \\*' to list packages and drop the nixpkgs. prefix"
      return 1
    }

    [ -n "$nixpkgs_version" ] || {
      echo >&2 "didn't specify what nixpkgs version to use, rerun like this:"
      echo >&2 "ceh_nixpkgs_install $pkgattr $(cat /nix/var/nix/profiles/per-user/root/channels/nixpkgs/relname | sed 's/^nixpkgs-//')"
      return 1
    }

    ceh_nixpkgs_init_version $nixpkgs_version

    echo $NIX_PATH
    local current_derivation=$($CEH_NIX/bin/nix-instantiate '<ceh_nixpkgs>' -A $pkgattr)
    [ "${current_derivation#/nix/store/}" != "$current_derivation" ] || {
      echo >&2 "failed to derive nixpkgs.$pkgattr in nixpkgs-$nixpkgs_version"
      return 1
    }

    [ "/nix/store/$derivation" = "$current_derivation" ] || {
      echo >&2 "derivation was unspecified or incorrect, rerun like this:"
      echo >&2 "ceh_nixpkgs_install $pkgattr $nixpkgs_version ${current_derivation#/nix/store/}"
      return 1
    }

    [ "$(nix-store -q $current_derivation | wc -l)" = 1 ] || {
      echo >&2 "derivations with multiple outputs are not supported"
      return 1
    }

    local outpath=$(nix-store -q $current_derivation)
    [ "/nix/store/$out" = "$outpath" ] || {
      echo >&2 "nix out dir was unspecified or incorrect, rerun like this:"
      echo >&2 "ceh_nixpkgs_install $pkgattr $nixpkgs_version $derivation ${outpath#/nix/store/}"
      return 1
    }

    nix-store -r $current_derivation
    mkdir -p $(dirname $profile)
    nix-env -p $profile -i $outpath
    ceh_nix_update_cache $profile
  )

  local retval=$?
  if [ "$retval" -eq 0 ]; then
    ceh_nix_install_root=/nix/store/$out
    return 0
  else
    ceh_nix_install_root=
    return $retval
  fi
}

ceh_nixpkgs_install_for_ghc() {
  ceh_nixpkgs_install "$1" "$2" "$3" "$4" /nix/var/nix/profiles/ceh/ghc-libs
}

# Use this profile when you're installing packages used only by the
# functions in these files.  E.g. the which package for ceh_exclude.
ceh_nixpkgs_install_tools() {
  ceh_nixpkgs_install "$1" "$2" "$3" "$4" /nix/var/nix/profiles/ceh/tools
}

# Use this profile when you're installing packages for emacs.
ceh_nixpkgs_install_for_emacs() {
  ceh_nixpkgs_install "$1" "$2" "$3" "$4" /nix/var/nix/profiles/ceh/emacs
}

ceh_exclude() {
  [ -n "$1" ] || {
    echo >&2 "Usage: ceh_exclude <executable-to-exclude-from-ceh>"
    return 1
  }

  [ -e "/opt/ceh/bin-user/$1" ] && {
    echo >&2 "Already excluded, /opt/ceh/bin-user/$1 already exists"
    return 1
  }

  [ -x "/opt/ceh/bin/$1" ] || {
    echo >&2 "/opt/ceh/bin/$1 is not an executable, can't be excluded"
    return 1
  }

  ceh_nixpkgs_install_tools which 1.0pre23218_eda055d \
    q2bl85vvnvsdrcfbjxjizg0yvlip94bj-which-2.20.drv \
    s3ilf7fffhkydmcl7ccrb0sq6808lyan-which-2.20

  REALBIN=$(/nix/store/s3ilf7fffhkydmcl7ccrb0sq6808lyan-which-2.20/bin/which -a "$1" | grep -v ^/opt/ceh/bin | head -n1)

  [ -n "$REALBIN" ] || {
    echo >&2 "No non-ceh binary found in your PATH for $1"
    return 1
  }

  echo >&2 "Excluding $1: creating symlink from /opt/ceh/bin-user/$1 -> $REALBIN"
  ln -s "$REALBIN" "/opt/ceh/bin-user/$1"
}

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

# Initializes Nix's GCC environment for ghc: sets PATH and envvars hacked to
# include libs installed into the /nix/var/nix/profiles/ceh/ghc-libs profile.
# Ensures that the appropriate ghc package is installed and exports its path in
# $ceh_ghc_root.
ceh_init_gcc_env_for_ghc() {
  if [ -z "$CEH_GCC_WRAPPER_FLAGS_SET" ]; then
    export NIX_LDFLAGS="-L /nix/var/nix/profiles/ceh/ghc-libs/lib $NIX_LDFLAGS"
    export NIX_CFLAGS_COMPILE="-idirafter /nix/var/nix/profiles/ceh/ghc-libs/include $NIX_CFLAGS_COMPILE"
    ceh_path_prepend "/nix/var/nix/profiles/ceh/ghc-libs/lib/pkgconfig" PKG_CONFIG_PATH || true
    ceh_nixpkgs_install gcc 1.0pre22121_e2e1526 \
      hg62ihjzhzs5rrxigqv312hkg6jc31dr-gcc-wrapper-4.6.3.drv \
      knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3
    ceh_path_prepend /nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin || {
      echo >&2 "/nix/store/knyqmizvmpi8bm745zbmalksplxd10sq-gcc-wrapper-4.6.3/bin is not installed"
      exit 1
    }

    CEH_GCC_WRAPPER_FLAGS_SET=1
  fi

  ceh_nixpkgs_install haskellPackages_ghc762.ghc 1.0pre23717_789154b \
    w2hdx6392d6hyy6hpmk76ss85wfzh2x3-ghc-7.6.2-wrapper.drv \
    mbwh1yyq5vzrslns8l2a6bz6ph4w0xaz-ghc-7.6.2-wrapper
  ceh_ghc_root=$ceh_nix_install_root
}
