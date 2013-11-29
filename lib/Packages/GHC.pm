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
        $ENV{NIX_LDFLAGS}="-lgcc_s -L /nix/var/nix/profiles/ceh/$ghclibs/lib " . ($ENV{NIX_LDFLAGS} or "");
        $ENV{NIX_CFLAGS_COMPILE}="-idirafter /nix/var/nix/profiles/ceh/$ghclibs/include " . ($ENV{NIX_CFLAGS_COMPILE} or "");
        path_prepend("/nix/var/nix/profiles/ceh/$ghclibs/lib/pkgconfig", 'PKG_CONFIG_PATH');
        my $outgcc;
        if ($ENV{CEH_GHC64}) {
            $outgcc = ceh_nixpkgs_install_ghctools64("gcc", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'llfxzryvp9cra2c806xmjjmmnws8mpcp-gcc-wrapper-4.6.3.drv', out => 'imgyva7wqc81w91q1agfrqk77b827hqv-gcc-wrapper-4.6.3');
        } else {
            $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'ih9s242amrdizp6cqn41ws45igmrg278-gcc-wrapper-4.6.3.drv', out => 'q09m5iknwzqcb4js54pmghzqzd18wz08-gcc-wrapper-4.6.3');
        }
        path_prepend("$outgcc/bin");
        my $outpkg;
        if ($ENV{CEH_GHC64}) {
            $outpkg = ceh_nixpkgs_install_ghctools64("pkgconfig", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'n419f6xhlsb550h1c2vg8nfbfgcwbr56-pkg-config-0.23.drv', out => '2dzzk7qs89bhl1lz0ywbhphd2ys96l10-pkg-config-0.23');
        } else {
            $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'qmgj6v2nd9kmha7p0vh37mi1yyj7z42x-pkg-config-0.23.drv', out => 'sjg0j92drrip1pch65srsxa9jw0zq4g6-pkg-config-0.23');
        }
        path_prepend("$outpkg/bin");
        $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
if ($ENV{CEH_GHC64}) {
    $ceh_ghc_root=ceh_nixpkgs_install_bin64("cehGHC", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '89v2xi6x4jx4lwd8n7n3alfgm57pm4p5-haskell-env-ghc-7.6.3.drv', out => '9lia10p9m125p8v3bdcclik3zxszi5r8-haskell-env-ghc-7.6.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install_bin("cehGHC", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'nmxcal0d0lyjg0s2dywlcbs75pcrw17d-haskell-env-ghc-7.6.3.drv', out => 'didbcdy10nplxlzcl14nw5567ncb143x-haskell-env-ghc-7.6.3');
}

1;
