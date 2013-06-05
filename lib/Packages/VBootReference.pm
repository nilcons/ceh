package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/VBootReference.nix';
ceh_nixpkgs_install("vboot_reference", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'n7rn03iyngr7gsc8bvamq2bvh97g4xnp-vboot_reference-37.43837.2.drv', out => '8k4rc1yh0iymg9x7cyi1ll4ckyj9bk9l-vboot_reference-37.43837.2');

1;
