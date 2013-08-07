package Packages::GHC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_ghc_root);

our $ceh_ghc_root = '';

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/GHC.nix";

# Initializes Nix's GCC environment for GHC: sets PATH and envvars hacked to
# include libs installed into the /nix/var/nix/profiles/ceh/ghc-libs profile.
# Ensures that the appropriate ghc package is installed and exports its path in
# $ceh_ghc_root.
if (not $ENV{CEH_GCC_WRAPPER_FLAGS_SET}) {
	$ENV{NIX_LDFLAGS}="-L /nix/var/nix/profiles/ceh/ghc-libs/lib " . ($ENV{NIX_LDFLAGS} or "");
	$ENV{NIX_CFLAGS_COMPILE}="-idirafter /nix/var/nix/profiles/ceh/ghc-libs/include " . ($ENV{NIX_CFLAGS_COMPILE} or "");
	path_prepend("/nix/var/nix/profiles/ceh/ghc-libs/lib/pkgconfig", 'PKG_CONFIG_PATH');
	my $outgcc = ceh_nixpkgs_install_for_ghc("gcc", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => '9jcxj7fr89in7074ycqzrrgfgc6wd8ci-gcc-wrapper-4.6.3.drv', out => 'q09m5iknwzqcb4js54pmghzqzd18wz08-gcc-wrapper-4.6.3');
	path_prepend("$outgcc/bin");
	my $outpkg = ceh_nixpkgs_install_for_ghc("pkgconfig", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => '7kiw825s9cd681088b1brnf1pajabry3-pkg-config-0.23.drv', out => 'sjg0j92drrip1pch65srsxa9jw0zq4g6-pkg-config-0.23');
	path_prepend("$outpkg/bin");
	$ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
$ceh_ghc_root=ceh_nixpkgs_install_bin("cehGHC", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => 'pb61h4nfgbbwjkwshvb9nzzpz49a8gip-haskell-env-ghc-7.6.3.drv', out => 'zmli2qd60rn8mnv84b7dwhf34925fdn3-haskell-env-ghc-7.6.3');

path_prepend('/nix/var/nix/profiles/ceh/ghc-libs/lib', 'LD_LIBRARY_PATH');

1;
