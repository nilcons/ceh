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
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", bit32 => 1, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '7i77fmrlcmxd1pyf6xfjjd4lm6h2xs2z-haskell-env-ghc-7.8.4');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'nh0bbk8bzcfb9xck5dxcwj7xab0d03ds-haskell-env-ghc-7.8.4');
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
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", bit32 => 1, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'grixz3mkdx3pzrdqpnrkmf3y3aw5jip0-gcc-wrapper-4.8.4');
    } else {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'qsl51gm9qcwngdsl6myg9gx8sq51skdm-gcc-wrapper-4.8.4');
    }
    path_prepend("$outgcc/bin");

    my $outpkg;
    if ($ENV{CEH_GHC32}) {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", bit32 => 1, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '3yxmrxmknbxdc4fawy5wm8531q9bq819-pkg-config-0.28');
    } else {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'qfmwj9pwl9vl5may0ln9f7wg5z4l8vjm-pkg-config-0.28');
    }
    path_prepend("$outpkg/bin");
    $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}

1;
