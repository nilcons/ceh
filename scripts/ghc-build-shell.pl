#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

# See README.compile-ghc-with-ceh

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehBase;
use CehInstall;
use Packages::GHC;

sub ceh_nixpkgs_install_ghcbuildbin {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, "/nix/var/nix/profiles/ceh/ghc-build-bin", %opts);
}

ceh_nixpkgs_install_ghcbuildbin("perl", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'qdpy0c5a6w04q63zw70phgal7z4xk5wq-perl-5.16.3.drv', out => 'x39yy4fg60qqgdrjhbwzrjs8r7w5wmzy-perl-5.16.3');
ceh_nixpkgs_install_ghcbuildbin("gnumake", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'phspbj3bkgbh4jspyg170v1v5hkvb4cd-gnumake-3.82.drv', out => '057196vxl4ksams9fjfcgq00w9y4avdh-gnumake-3.82');
ceh_nixpkgs_install_ghcbuildbin("m4", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'pb0vakgfhwzll3546pm0i7fa16b772v7-gnum4-1.4.16.drv', out => '4p4j7jrxw5bvc74vxla5y64wcjiznz74-gnum4-1.4.16');

# stupid info collission between autoconf and binutils
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 1 autoconf >&2");
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 2 binutils >&2");
ceh_nixpkgs_install_ghcbuildbin("autoconf", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'jz3bgk7vy1ds6pi1bwjs175krkk6i1p8-autoconf-2.69.drv', out => 'ca8ycvpcbmgjbm90ba0a5ny61kfl12d1-autoconf-2.69');
ceh_nixpkgs_install_ghcbuildbin("automake", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '4204n9q10i2fbfdf89kmb57fl5f49bmw-automake-1.12.4.drv', out => '4bf7jxmqk5sr0i01aw3mb45ikdndr17n-automake-1.12.4');
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 1 autoconf >&2");
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 2 binutils >&2");

# TODO(errge): get rid of this conditional
# https://github.com/NixOS/nixpkgs/pull/857 hits the nixpkgs
if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install("binutils", "/nix/var/nix/profiles/ceh/ghc-build-bin64", bit64 => 1, nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'q5y2qpasbzhdii13yays1g5qyin920j3-binutils-2.23.1.drv', out => '46595bx2k3yjznihv898592qnzirbvgm-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin64/bin");
} else {
    ceh_nixpkgs_install_ghcbuildbin("binutils", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'm8znks1f71rl183f9ql41f505czsxzpd-binutils-2.23.1.drv', out => 'if62bg6a0g5kv2xqjk54hmpl5y0r8dzh-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");
}

# TODO(errge): once todo in GHC.pm completed, this can use that infrastructure.
my $outncurses;
my $outgmp;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', bit64 => 1, nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'bdbzkzw4aagfw6rj3p6nkwsmwqach02v-ncurses-5.9.drv', out => 'q96qckiwzh055rd2b0fsnkd0a4xr5nis-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', bit64 => 1, nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '6yl8rr3byk9hfkh0vxg1bzhpwjcq1jss-gmp-5.0.5.drv', out => 'xhi96qw8i4ms3q1z1grh6jsgwgz3sm4i-gmp-5.0.5');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '9yybsrlzb4vggql130als53c30yiw05d-ncurses-5.9.drv', out => 'hc4rlhbd7rfyx5l44kdhly6ckam1b3rg-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'cssxdw5xlh0znli6mcqg6cnvdhfswb4d-gmp-5.0.5.drv', out => 'c9qp80wg4qc2dnphpl49fa3kn1kx7802-gmp-5.0.5');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib -L $outgmp/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include -idirafter $outgmp/include";
# the GHC build process uses the built
path_prepend("$outgmp/lib", 'LD_LIBRARY_PATH');

exec "/bin/bash", @ARGV;
