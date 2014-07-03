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

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC.nix";

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
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'gnk8w6qh6fwfamwy8ipl8zg149inw9rg-gcc-wrapper-4.8.3');
    } else {
        $outgcc = ceh_nixpkgs_install_ghctools("gcc", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '12a0cqxj5gzbacsz3awwaid567ig19cq-gcc-wrapper-4.8.3');
    }
    path_prepend("$outgcc/bin");

    my $outpkg;
    if ($ENV{CEH_GHC64}) {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '4fyr6a8wdz1i0n1vf8n7bk3zaf6jfbg7-pkg-config-0.28');
    } else {
        $outpkg = ceh_nixpkgs_install_ghctools("pkgconfig", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'jws9fg4l7s5lz6pf8bc4ax7h17pywq08-pkg-config-0.28');
    }
    path_prepend("$outpkg/bin");
    $ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
if ($ENV{CEH_GHC64}) {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'l54ivgy18gx628ajx4np9ag53wlq5p1b-haskell-env-ghc-7.6.3');
} else {
    $ceh_ghc_root=ceh_nixpkgs_install("cehGHC", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '76i51q1y1zlyw7j9024vzvg0imlfmjqg-haskell-env-ghc-7.6.3');
}

1;
