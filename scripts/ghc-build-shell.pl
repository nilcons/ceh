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

ceh_nixpkgs_install_ghcbuildbin("perl", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'b15kvbqyfbb6np5d7lrjsjz5vwbs7126-perl-5.16.3');
ceh_nixpkgs_install_ghcbuildbin("gnumake", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => '589lxrnab3yrg1mn3vhg2p30f4r0kyhd-gnumake-3.82');
ceh_nixpkgs_install_ghcbuildbin("m4", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'fgi8my3g0zzfrvifn61s5087458p77js-gnum4-1.4.17');

# stupid info collission between autoconf and binutils
systemdie("/opt/ceh/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 1 autoconf >&2");
systemdie("/opt/ceh/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 2 binutils >&2");
ceh_nixpkgs_install_ghcbuildbin("autoconf", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'svv52l4g0arspp537m5jrvcjjjns0yqp-autoconf-2.69');
ceh_nixpkgs_install_ghcbuildbin("automake", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'mmh1vwwnvzkqmljw8m1w6y5y0356r0ps-automake-1.12.4');
systemdie("/opt/ceh/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 1 autoconf >&2");
systemdie("/opt/ceh/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 2 binutils >&2");

# TODO(errge): get rid of this conditional
# https://github.com/NixOS/nixpkgs/pull/857 hits the nixpkgs
if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install("binutils", "/nix/var/nix/profiles/ceh/ghc-build-bin64", bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'dyb8q2dx4dnbxpajf9inycjh49mabmdy-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin64/bin");
} else {
    ceh_nixpkgs_install_ghcbuildbin("binutils", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'vbkccaycpd4p64ldw0m7nynlkkrwpglm-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");
}

# TODO(errge): once todo in GHC.pm completed, this can use that infrastructure.
my $outncurses;
my $outgmp;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => '9ixnhyfnypvh85pr6qx8a5cljc6q2ya0-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => '45i1saazxy68pkygdqzllbxg83py4928-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'xybmnq4cy1swgazlp7hck5q8s4q7hgn1-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'bdnnw6lj1r6fhap8215yqyr7i62z8sr4-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib -L $outgmp/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include -idirafter $outgmp/include";
# the GHC build process uses the built
path_prepend("$outgmp/lib", 'LD_LIBRARY_PATH');

exec "/bin/bash", @ARGV;
