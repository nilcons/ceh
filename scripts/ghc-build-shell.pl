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

ceh_nixpkgs_install_ghcbuild("perl", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '9b1pb98rgdw550wlcdmy6aafyasqz7mj-perl-5.16.3');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("gnumake", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '7j3apq0wnqxgi5z2rchicvnl517iqkn5-gnumake-3.82');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("m4", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '3j5i0x65q5rsvbmd85flzjafi1f5y34j-gnum4-1.4.17');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("autoconf", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '4ycf2rbbqw6l88q4shmz6kx4rrhdbnzv-autoconf-2.69');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("automake", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'n6bbmshlzz6ygljcjmh37dlc1rmwnmzm-automake-1.12.6');
path_prepend($ceh_nix_install_root . "/bin");

if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install_ghcbuild("binutils", bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'bzvdg7g74rkw7p3zw3mqpp7ynnq4mxf1-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
} else {
    ceh_nixpkgs_install_ghcbuild("binutils", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '4icsmrpiavshy3mwyxrwcy7lq65l7jyx-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
}

my $outncurses;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'ndsw7gcr9mq7w0h1nbbh25zwv7imcs6y-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'zr69zmc55b3d9wh0k6r4bs1g4mv5wclr-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'kj0wqfrpip9ixw5f0lbj35qrprrcd5ay-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'qamk6p7rx0qyipcncbiqacpdk5ydir0l-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include";

exec "bash", @ARGV;
