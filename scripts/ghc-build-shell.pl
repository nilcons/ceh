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

ceh_nixpkgs_install_ghcbuild("perl", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'g9ybksy400pfn7fncw8dqfnz6m7fdyrk-perl-5.20.1');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("gnumake", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'n93nwrnhj711053pxvhaj7vgi6ivxjr3-gnumake-3.82');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("m4", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '73219iazfyfa6b5f2hnpjvqcjkwc6745-gnum4-1.4.17');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("autoconf", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'kslbs5n87i6hlf4a33h7w6fcp2ydv81d-autoconf-2.69');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("automake", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'hqzvkxgg1v9fy6n2a3n5pra1kkh3974f-automake-1.12.6');
path_prepend($ceh_nix_install_root . "/bin");

if ($ENV{CEH_GHC32}) {
    ceh_nixpkgs_install_ghcbuild("binutils", bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'p9iacwx6c2lcjlig4g06vvrcvl2gqndk-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
} else {
    ceh_nixpkgs_install_ghcbuild("binutils", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'b8qhjrwf8sf9ggkjxqqav7f1m6w83bh0-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
}

my $outncurses;
if ($ENV{CEH_GHC32}) {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '5f355y6gbihz3p0jqgrrirjf0rwcjp8x-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '4qggnahmiml6mjqfiklhmd8riabmrrd6-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '4hz3s6apn27qwfq5bqdkg10pvlxgcn4d-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '6l8mc2qgfq6z0hs4flgchwjvlxwl4qv7-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include";

exec "bash", @ARGV;
