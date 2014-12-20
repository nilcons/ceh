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
if (not $ENV{CEH_GCC_WRAPPER_FLAGS_SET}) {
    # for -lgcc_s see: http://lists.science.uu.nl/pipermail/nix-dev/2013-October/011891.html
    my $env_nix_ldflags = "-lgcc_s -L /opt/ceh/lib/fake_libgcc_s ";
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
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '2gjrvig5qwvsks6nixrm549w6fca1ybi-gcc-wrapper-4.8.3');
    } else {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'w1lj2s6v2wjmgd44fdi9i1p53qbxrqdc-gcc-wrapper-4.8.3');
    }
    path_prepend("$outgcc/bin");

    my $outpkg;
    if ($ENV{CEH_GHC32}) {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'ynj7xzs9h4qg2bdn3l9smqbg5jbfv5ag-pkg-config-0.28');
    } else {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'hpnsswyh6qkjy5yvrf0a50k6cgm8cws8-pkg-config-0.28');
    }
    path_prepend("$outpkg/bin");
    $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC.nix";

if ($ENV{CEH_GHC32}) {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'mm4dr91xbzm9cs13ls4qakd1njmg6d7k-haskell-env-ghc-7.8.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'b9hzy2ahicrr93irydxmbsidz0i3hn9w-haskell-env-ghc-7.8.3');
}

1;
