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

ceh_nixpkgs_install_ghcbuildbin("perl", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'mq4nm7m2xx1v2lbnr7rlbm83sqjbyzxf-perl-5.16.3.drv', out => 'b15kvbqyfbb6np5d7lrjsjz5vwbs7126-perl-5.16.3');
ceh_nixpkgs_install_ghcbuildbin("gnumake", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'h3whp94hgs14vpmgcan6pfwxn1fiz9nb-gnumake-3.82.drv', out => '589lxrnab3yrg1mn3vhg2p30f4r0kyhd-gnumake-3.82');
ceh_nixpkgs_install_ghcbuildbin("m4", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'pzvalx40xly0gny2ssppi7wirizsjncr-gnum4-1.4.17.drv', out => 'fgi8my3g0zzfrvifn61s5087458p77js-gnum4-1.4.17');

# stupid info collission between autoconf and binutils
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 1 autoconf >&2");
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 2 binutils >&2");
ceh_nixpkgs_install_ghcbuildbin("autoconf", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '0sj2yp0b1ygym7557dwbr33wr2kjngkv-autoconf-2.69.drv', out => 'svv52l4g0arspp537m5jrvcjjjns0yqp-autoconf-2.69');
ceh_nixpkgs_install_ghcbuildbin("automake", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'vgqqxsvd3b4r4dl7ld6aydc67bvd5fz9-automake-1.12.4.drv', out => 'mmh1vwwnvzkqmljw8m1w6y5y0356r0ps-automake-1.12.4');
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 1 autoconf >&2");
systemdie("$CEH_NIX/bin/nix-env -p /nix/var/nix/profiles/ceh/ghc-build-bin --set-flag priority 2 binutils >&2");

# TODO(errge): get rid of this conditional
# https://github.com/NixOS/nixpkgs/pull/857 hits the nixpkgs
if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install("binutils", "/nix/var/nix/profiles/ceh/ghc-build-bin64", bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '225bsfykxa64xzjszgw19v3ysks8p9yh-binutils-2.23.1.drv', out => 'dyb8q2dx4dnbxpajf9inycjh49mabmdy-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin64/bin");
} else {
    ceh_nixpkgs_install_ghcbuildbin("binutils", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '913k79xzfxawi3wiirnc8spb2pfqkqrw-binutils-2.23.1.drv', out => 'vbkccaycpd4p64ldw0m7nynlkkrwpglm-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");
}

# TODO(errge): once todo in GHC.pm completed, this can use that infrastructure.
my $outncurses;
my $outgmp;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '0ky41jrsh73xzrgzazihc7k916nfrmh3-ncurses-5.9.drv', out => '9ixnhyfnypvh85pr6qx8a5cljc6q2ya0-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'cvxkjklqly26lk783ak3cxc2yv3ljc93-gmp-5.1.3.drv', out => '45i1saazxy68pkygdqzllbxg83py4928-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'wqz8vfyn51rpw71rrzzqx5h21bplnpbb-ncurses-5.9.drv', out => 'xybmnq4cy1swgazlp7hck5q8s4q7hgn1-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'kc8qrr7qighnm6d4qrr04izc85l928ra-gmp-5.1.3.drv', out => 'bdnnw6lj1r6fhap8215yqyr7i62z8sr4-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib -L $outgmp/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include -idirafter $outgmp/include";
# the GHC build process uses the built
path_prepend("$outgmp/lib", 'LD_LIBRARY_PATH');

exec "/bin/bash", @ARGV;
