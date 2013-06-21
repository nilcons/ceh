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
	my $outgcc = ceh_nixpkgs_install("gcc", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => '2qpldc11v53c045p5s8kg5vx8pdcw18c-gcc-wrapper-4.6.3.drv', out => 'qk296xnr5zqqjjckkxayyjlhl70y8awb-gcc-wrapper-4.6.3');
	path_prepend("$outgcc/bin");
	my $outpkg = ceh_nixpkgs_install("pkgconfig", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => 'ysif6pp2g800clfwkyzq5ncs8dm7fzv4-pkg-config-0.23.drv', out => 'qg882f4p8d1kz6pjlcp9f717q7vp7frc-pkg-config-0.23');
	path_prepend("$outpkg/bin");
	$ENV{CEH_GCC_WRAPPER_FLAGS_SET}=1;
}
$ceh_ghc_root=ceh_nixpkgs_install("cehGHC", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => 'x64llcjg0rla7bbqcfpicrjfr5vygl87-haskell-env-ghc-7.6.3.drv', out => 'n56rv8svysgqvpy066k9bi7fdkwy4jzi-haskell-env-ghc-7.6.3');

path_prepend('/nix/var/nix/profiles/ceh/ghc-libs/lib', 'LD_LIBRARY_PATH');

1;
