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
        $ENV{NIX_LDFLAGS}="-L /nix/var/nix/profiles/ceh/$ghclibs/lib " . ($ENV{NIX_LDFLAGS} or "");
        $ENV{NIX_CFLAGS_COMPILE}="-idirafter /nix/var/nix/profiles/ceh/$ghclibs/include " . ($ENV{NIX_CFLAGS_COMPILE} or "");
        path_prepend("/nix/var/nix/profiles/ceh/$ghclibs/lib/pkgconfig", 'PKG_CONFIG_PATH');
        my $outgcc;
        if ($ENV{CEH_GHC64}) {
            $outgcc = ceh_nixpkgs_install_ghctools64("gcc", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'llfxzryvp9cra2c806xmjjmmnws8mpcp-gcc-wrapper-4.6.3.drv', out => 'imgyva7wqc81w91q1agfrqk77b827hqv-gcc-wrapper-4.6.3');
        } else {
            $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'ih9s242amrdizp6cqn41ws45igmrg278-gcc-wrapper-4.6.3.drv', out => 'q09m5iknwzqcb4js54pmghzqzd18wz08-gcc-wrapper-4.6.3');
        }
        path_prepend("$outgcc/bin");
        my $outpkg;
        if ($ENV{CEH_GHC64}) {
            $outpkg = ceh_nixpkgs_install_ghctools64("pkgconfig", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'n419f6xhlsb550h1c2vg8nfbfgcwbr56-pkg-config-0.23.drv', out => '2dzzk7qs89bhl1lz0ywbhphd2ys96l10-pkg-config-0.23');
        } else {
            $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'qmgj6v2nd9kmha7p0vh37mi1yyj7z42x-pkg-config-0.23.drv', out => 'sjg0j92drrip1pch65srsxa9jw0zq4g6-pkg-config-0.23');
        }
        path_prepend("$outpkg/bin");
        $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
if ($ENV{CEH_GHC64}) {
    $ceh_ghc_root=ceh_nixpkgs_install_bin64("cehGHC", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '1a6sshwhcnba8k0hhgngw3big2f7iv4y-haskell-env-ghc-7.6.3.drv', out => 'h8g0hqsraxsy3y566s9k7081ih6x5sw4-haskell-env-ghc-7.6.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install_bin("cehGHC", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'cqjab06187jy1p43p28xgbdkkb37zdxk-haskell-env-ghc-7.6.3.drv', out => 'mb9g35bbclkx16dnc345pvw41yhfhwpn-haskell-env-ghc-7.6.3');
}

1;
