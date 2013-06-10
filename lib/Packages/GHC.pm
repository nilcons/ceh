package Packages::GHC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_ghc_root);

our $ceh_ghc_root = '';

# Initializes Nix's GCC environment for GHC: sets PATH and envvars hacked to
# include libs installed into the /nix/var/nix/profiles/ceh/ghc-libs profile.
# Ensures that the appropriate ghc package is installed and exports its path in
# $ceh_ghc_root.
if (not $ENV{CEH_GCC_WRAPPER_FLAGS_SET}) {
	$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/ghc.nix";
	$ENV{NIX_LDFLAGS}="-L /nix/var/nix/profiles/ceh/ghc-libs/lib " . ($ENV{NIX_LDFLAGS} or "");
	$ENV{NIX_CFLAGS_COMPILE}="-idirafter /nix/var/nix/profiles/ceh/ghc-libs/include " . ($ENV{NIX_CFLAGS_COMPILE} or "");
	path_prepend("/nix/var/nix/profiles/ceh/ghc-libs/lib/pkgconfig", 'PKG_CONFIG_PATH');
	my $outgcc = ceh_nixpkgs_install("gcc", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => '2qpldc11v53c045p5s8kg5vx8pdcw18c-gcc-wrapper-4.6.3.drv', out => 'qk296xnr5zqqjjckkxayyjlhl70y8awb-gcc-wrapper-4.6.3');
	path_prepend("$outgcc/bin");
	my $outpkg = ceh_nixpkgs_install("pkgconfig", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'ysif6pp2g800clfwkyzq5ncs8dm7fzv4-pkg-config-0.23.drv', out => 'qg882f4p8d1kz6pjlcp9f717q7vp7frc-pkg-config-0.23');
	path_prepend("$outpkg/bin");
	$ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
$ceh_ghc_root=ceh_nixpkgs_install("hsEnv", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => '0l4sakgj9n8ahbiff1zzq1lnkaf1q47g-haskell-env-ghc-7.6.3.drv', out => 'zyfqcf2ka98jx202qsxf2c71xag6zw2c-haskell-env-ghc-7.6.3');

path_prepend('/nix/var/nix/profiles/ceh/ghc-libs/lib', 'LD_LIBRARY_PATH');

1;
