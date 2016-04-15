package Packages::GHC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_ghc_root @ceh_ghc_libs);

our $ceh_ghc_root = '';
our @ceh_ghc_libs = ();

sub ceh_nixpkgs_install_ghctools {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, gclink => "/opt/ceh/installed/ghctools/$pkgattr", %opts);
}

# Initializes Nix's GCC environment for GHC: sets PATH and envvars hacked to
# include libs installed into the /opt/ceh/installed/ghclibs.
# Ensures that the appropriate ghc package is installed and exports its path in
# $ceh_ghc_root.  Returns @ceh_ghc_libs with the list of paths that should be
# added to LD_LIBRARY_PATH e.g. in ghc, ghci and ghc-mod.  We don't change
# LD_LIBRARY_PATH here, because e.g. in /opt/ceh/bin/pandoc we want to leave it
# unchanged.

# Investigation needed on why moving cehGHC installation before the
# installation of gcc helps, but with nix 1.8 (or with some nixpkgs
# change at the same time) the normal order of first installing
# gcc+pkgconfig, then cehGHC doesn't work anymore.  Strange.
# Reproduce this way: do a full ceh-purge, then ceh-init and
# "ceh_nixpkgs_install gcc" will try to build instead of downloading
# from binary cache.  On the other hand, first doing a
# "NIXPKGS_CONFIG=/opt/ceh/lib/Packages/GHC.nix ceh_nixpkgs_install cehGHC"
# and then doing the "ceh_nixpkgs_install gcc" will work.
$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC.nix";
if ($ENV{CEH_GHC32}) {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", bit32 => 1, nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '2ncn5yxacpiahppxg4nri3na2imriw1b-ghc-7.10.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'qs26k5r898q9dp6jgzmqlr2f5yxd0sg9-ghc-7.10.3');
}

if (not $ENV{CEH_GCC_WRAPPER_FLAGS_SET}) {
    my $env_nix_ldflags = "";
    my $env_nix_cflags_compile = "";

    my @ghclibs = ();
    my @links = </opt/ceh/installed/ghclibs/*>;
    foreach my $link (@links) {
        next unless -l $link;
        my $target = readlink("$link");
        next unless ($target =~ /^\/nix\/store\//);
        next unless ($ENV{CEH_GHC32} xor $link !~ /.32$/);

        push @ceh_ghc_libs, "$target/lib";
        $env_nix_ldflags .= "-L $target/lib ";
        $env_nix_cflags_compile .= "-idirafter $target/include ";
        path_prepend("$target/lib/pkgconfig", 'PKG_CONFIG_PATH');
    }

    $env_nix_ldflags .= $ENV{NIX_LDFLAGS} || "";
    $env_nix_cflags_compile .= $ENV{NIX_CFLAGS_COMPILE} || "";

    $ENV{NIX_LDFLAGS} = $env_nix_ldflags;
    $ENV{NIX_CFLAGS_COMPILE} = $env_nix_cflags_compile;

    my $outgcc;
    if ($ENV{CEH_GHC32}) {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", bit32 => 1, nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '7ivnxl0687vysg45cz71x5ap80g9cjpq-gcc-wrapper-5.3.0');
    } else {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'h6v091al32h655vf4isnq3h3fmnxn8qg-gcc-wrapper-5.3.0');
    }
    path_prepend("$outgcc/bin");

    my $outpkg;
    if ($ENV{CEH_GHC32}) {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", bit32 => 1, nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'nn1p9v9hdzwa2nz8q3fag3nh9mkpdsx0-pkg-config-0.29');
    } else {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'm77pjw9ldii0jmcvx3l62fy6ml3wclrr-pkg-config-0.29');
    }
    path_prepend("$outpkg/bin");
    $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}

1;
