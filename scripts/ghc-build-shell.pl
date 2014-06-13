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

ceh_nixpkgs_install_ghcbuild("perl", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '6mw6078n0lj5h90l7qpqfdz0f93hk9jc-perl-5.16.3');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("gnumake", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'm7xh82gf4f1jqrbz4nzp3j3ag9ygr02w-gnumake-3.82');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("m4", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '14hhn6jvbk97g9b4yz44gyjjw7qgj7ca-gnum4-1.4.17');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("autoconf", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'lscrc8sc3fd5w41i8kgwf3gaw75k41jd-autoconf-2.69');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("automake", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'dmz8lzs7kmc2f8vh1m97hw6w21hr46j2-automake-1.12.6');
path_prepend($ceh_nix_install_root . "/bin");

if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install_ghcbuild("binutils", bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'xjvdpqgn2kd4rg0k30z020kxylvlbpx0-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
} else {
    ceh_nixpkgs_install_ghcbuild("binutils", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'ih8inyk88ipx450838rwxcvpbxxz9lj6-binutils-2.23.1');
    path_prepend($ceh_nix_install_root . "/bin");
}

my $outncurses;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '8h3mfka2jmbjgaqdh1b95h7vh28j8906-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'wxkad81khi8gzxs8kppq5yqkki5hy0np-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '3v2029bmc8ay73sa9yn4yrgil5jf8l0c-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'qnkyas42nf0knps3va30y29y3zvmgy2v-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include";

exec "bash", @ARGV;
