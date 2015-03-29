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

ceh_nixpkgs_install_ghcbuild("perl", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'py2az85s8vfbi26pc9mxcp2q2686gkiv-perl-5.20.1');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("gnumake", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'mxbszq4y1mr269vs79mn6x1ddwiz0afi-gnumake-3.82');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("m4", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '9dhq6z45qzxnzb4wynkxvf7w9dwsya9w-gnum4-1.4.17');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("autoconf", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'srgk4fy940wy0xs3cn9i34kd0b9k0ik7-autoconf-2.69');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("automake", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'vmll2vs521zq82dmazs2qz5rwx0yg9d4-automake-1.14.1');
path_prepend($ceh_nix_install_root . "/bin");

if ($ENV{CEH_GHC32}) {
    ceh_nixpkgs_install_ghcbuild("binutils", bit32 => 1, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '9zj2vpf731gndhc2kag93khwvjryjnpp-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
} else {
    ceh_nixpkgs_install_ghcbuild("binutils", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '0gcq1z4b5y907rh5nmvpgmp28d928932-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
}

my $outncurses;
if ($ENV{CEH_GHC32}) {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', bit32 => 1, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'ysir7waypnr61dcn42i1imrx5nhr1zml-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', bit32 => 1, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '9ni4d60c32zr8hd3xl5c98qmhl9anfgz-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'pdak4pm9jqh2c91di4x2xk0m2gpa4r7g-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'pbzgy470imzf1lyjqz70j744n98f8j47-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include";

exec "bash", @ARGV;
