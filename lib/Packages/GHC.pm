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
        next unless ($ENV{CEH_GHC64} xor $link !~ /.64$/);

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
    if ($ENV{CEH_GHC64}) {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '085j31s6pfdwn6xl1g0x3i4pjcn2wvwf-gcc-wrapper-4.8.3');
    } else {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'c04lghgss1vx5dvn9v99dvb2jnvil7kz-gcc-wrapper-4.8.3');
    }
    path_prepend("$outgcc/bin");

    my $outpkg;
    if ($ENV{CEH_GHC64}) {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '4kzfxip40vlv08x26wb1wp0pmx3jfzqn-pkg-config-0.28');
    } else {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '89rlmcpc5jdg8sd8kqbw11d67crknhcx-pkg-config-0.28');
    }
    path_prepend("$outpkg/bin");
    $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}

if ($ENV{CEH_GHC76}) {
    $ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC76.nix";

    if ($ENV{CEH_GHC64}) {
        $ceh_ghc_root=ceh_nixpkgs_install("cehGHC76", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'g0fsf8lcakbax70zvny9g35a5j6yxi22-ghc-7.6.3');
    } else {
        $ceh_ghc_root=ceh_nixpkgs_install("cehGHC76", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'fd3blr0q9ky74hvd69qs8l2vlm2gigm6-ghc-7.6.3');
    }
} else {
    $ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC.nix";

    if ($ENV{CEH_GHC64}) {
        $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'iajzszrjrgv0c1chrjjnf6ahb5j9rq13-haskell-env-ghc-7.8.3');
    } else {
        $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '093ma4gqzcw36zw8m34kgd2gwl6m9ifs-haskell-env-ghc-7.8.3');
    }
}

1;
