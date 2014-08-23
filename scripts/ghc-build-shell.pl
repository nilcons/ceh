#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

# See README.compile-ghc-with-ceh

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehBase;
use CehInstall;
use Packages::GHC;

sub ceh_nixpkgs_install_ghcbuild {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, gclink => "/opt/ceh/installed/ghcbuild/$pkgattr", %opts);
}

ceh_nixpkgs_install_ghcbuild("perl", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'd11vm2pv9yx6xgq5hrwll3w7aqbslx47-perl-5.16.3');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("gnumake", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '6yw625i4djhrjqdj2i60cdz5bgxscvl7-gnumake-3.82');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("m4", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'yhhkh9xr50zi2hhr1wxavi26fd0mvxkb-gnum4-1.4.17');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("autoconf", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '0rk9i53fsl3vkplhmllrx6dw59x14fmg-autoconf-2.69');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("automake", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '85w1y25r0dsk8m89gw1ww6xpw3kfbg42-automake-1.12.6');
path_prepend($ceh_nix_install_root . "/bin");

if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install_ghcbuild("binutils", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'ngsbygsjzv0fbj1543306l0a48qqy1vs-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
} else {
    ceh_nixpkgs_install_ghcbuild("binutils", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'jky768r15np0fqbljdji7cgi5isnp7c4-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
}

my $outncurses;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'j55y6jxmcw15yi9zlmapbaqm7qf8jhyp-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'ni6j7jj3mxbg1af389xwl0wxb6pd7aki-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '4p92wj51hw3wmanjlkyqnammy1wnmfmr-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'z1l9npgr42dygj411xipz7d8r11132hg-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include";

exec "bash", @ARGV;
