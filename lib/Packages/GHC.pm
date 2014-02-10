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
            $outgcc = ceh_nixpkgs_install_ghctools64("gcc", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'awa8pp98c96rzr49hm8mnxyb1nn41ccy-gcc-wrapper-4.8.2.drv', out => 'gl3rwzkmlhls3msdphrj6f9r6992dnaw-gcc-wrapper-4.8.2');
        } else {
            $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'fz7dxhm85ih1wqnjslsdz5fmwyi0574a-gcc-wrapper-4.8.2.drv', out => 'xnb0w1i2jdjv178j1y28q4bfn79b8xia-gcc-wrapper-4.8.2');
        }
        path_prepend("$outgcc/bin");
        my $outpkg;
        if ($ENV{CEH_GHC64}) {
            $outpkg = ceh_nixpkgs_install_ghctools64("pkgconfig", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '6jayg66a1bk12bbs4g6hcbr64i5qp5rl-pkg-config-0.23.drv', out => 'n6757dx6nmp8vf4pwb5cm92yixiyxzwd-pkg-config-0.23');
        } else {
            $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'gw8z0a0bmgdprf888773bmh2ffgfcg98-pkg-config-0.23.drv', out => 'fgay13bx7pfg54xlyc3bnablinf3w87g-pkg-config-0.23');
        }
        path_prepend("$outpkg/bin");
        $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
if ($ENV{CEH_GHC64}) {
    $ceh_ghc_root=ceh_nixpkgs_install_bin64("cehGHC", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '14cjbk6ayjpzmlg7hvllkw9ck7mm44hn-haskell-env-ghc-7.6.3.drv', out => 'v651cl6n51ri74blyvpx57in9ab20rp5-haskell-env-ghc-7.6.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install_bin("cehGHC", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'hzffg4pzns1rkcndzp4yndm15naj2ggk-haskell-env-ghc-7.6.3.drv', out => 'b6mj9h0cbirz0i481qlcflilh9j1yvii-haskell-env-ghc-7.6.3');
}

1;
