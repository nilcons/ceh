package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/VBootReference.nix';
ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '008bb6935cddd3708ac4caf3360afb603ee5b4fa', derivation => 'jd5z6h3wbpm4g6hx3swyj7wyld8q2waz-vboot_reference-37.43837.2.drv', out => '8k4rc1yh0iymg9x7cyi1ll4ckyj9bk9l-vboot_reference-37.43837.2');

1;
