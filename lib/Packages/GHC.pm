package Packages::GHC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_ghc_root);

our $ceh_ghc_root = '';

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC.nix";

# TODO(errge): instead of directly NIX_LDFLAGS'ing to the profile, we
# should enumerate the packages and add a -L for all of them.  That
# way we would get much more pure libraries (test ldd of them,
# e.g. with hfuse).

# Initializes Nix's GCC environment for GHC: sets PATH and envvars hacked to
# include libs installed into the /nix/var/nix/profiles/ceh/ghc-libs[64] profile.
# Ensures that the appropriate ghc package is installed and exports its path in
# $ceh_ghc_root.
if (not $ENV{CEH_GCC_WRAPPER_FLAGS_SET}) {
        my $ghclibs;
        if ($ENV{CEH_GHC64}) {
            $ghclibs = "ghc-libs64";
        } else {
            $ghclibs = "ghc-libs";
        }
        # for -lgcc_s see: http://lists.science.uu.nl/pipermail/nix-dev/2013-October/011891.html
        $ENV{NIX_LDFLAGS}="-lgcc_s -L /opt/ceh/lib/fake_libgcc_s -L /nix/var/nix/profiles/ceh/$ghclibs/lib " . ($ENV{NIX_LDFLAGS} or "");
        $ENV{NIX_CFLAGS_COMPILE}="-idirafter /nix/var/nix/profiles/ceh/$ghclibs/include " . ($ENV{NIX_CFLAGS_COMPILE} or "");
        path_prepend("/nix/var/nix/profiles/ceh/$ghclibs/lib/pkgconfig", 'PKG_CONFIG_PATH');
        my $outgcc;
        if ($ENV{CEH_GHC64}) {
            $outgcc = ceh_nixpkgs_install_ghctools64("gcc", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'a6f4aw93ivyy3bx2zgb9d5i97hra4fvq-gcc-wrapper-4.8.2');
        } else {
            $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'bkxkrc38nixbp195kbr6jrf94mhcwzkz-gcc-wrapper-4.8.2');
        }
        path_prepend("$outgcc/bin");
        my $outpkg;
        if ($ENV{CEH_GHC64}) {
            $outpkg = ceh_nixpkgs_install_ghctools64("pkgconfig", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '1kg38wpfgrg96mmyv2r7d15rsn36r0xc-pkg-config-0.23');
        } else {
            $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'bgggs8q6m08pl3n5dniv24134zfcv43d-pkg-config-0.23');
        }
        path_prepend("$outpkg/bin");
        $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
if ($ENV{CEH_GHC64}) {
    $ceh_ghc_root=ceh_nixpkgs_install_bin64("cehGHC", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '2dc20q8qf9cyhkh9pr7b5hn8m3qlviwr-haskell-env-ghc-7.6.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install_bin("cehGHC", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'xkpy02jpsmdmhf0aw1hc1km81mx9ssgx-haskell-env-ghc-7.6.3');
}

1;
