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

ceh_nixpkgs_install_ghcbuild("perl", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '2vmlipl1acan7l5w02kv9rgwpyji32w9-perl-5.22.1');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("gnumake", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '7nrmx12q30lf760rs0jizlb6xh4i8pcr-gnumake-4.1');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("m4", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'pshh7lljaz5vadl31hzfks8mjvcsw6ni-gnum4-1.4.17');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("autoconf", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'rhvk30warwfbamaj991ab378qfycsc9y-autoconf-2.69');
path_prepend($ceh_nix_install_root . "/bin");

ceh_nixpkgs_install_ghcbuild("automake", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'jn6akprp4sqr9yai4mc2wliw6ynsp9fn-automake-1.15');
path_prepend($ceh_nix_install_root . "/bin");

if ($ENV{CEH_GHC32}) {
    ceh_nixpkgs_install_ghcbuild("binutils", bit32 => 1, nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'p5lg3yqr8asx3s2bcak9w1qqfwn71h3w-binutils-2.26');
    path_prepend($ceh_nix_install_root . "/bin");
} else {
    ceh_nixpkgs_install_ghcbuild("binutils", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'znk4sm83bggb5zd8r5qwavcgiq9s5ylf-binutils-2.26');
    path_prepend($ceh_nix_install_root . "/bin");
}

my $outncurses;
if ($ENV{CEH_GHC32}) {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', bit32 => 1, nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'a2bkwpimsgxs5ba0gr1xsql0l2i1b2xp-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', bit32 => 1, nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'py5lr355vkb5y4hgsv62fg078hmiisj3-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuild('ncurses', nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'slbqlh3pgjbln0767lnlqy0i0gi3lxza-ncurses-5.9');
    ceh_nixpkgs_install_ghcbuild('gmp', nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'hb5jw6g9wds4vr1wb9z9mcsnz40k86j4-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include";

exec "bash", @ARGV;
