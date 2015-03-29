package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '16zwrl4sfmzivscw64di4aw5ygh8nkkp-vboot_reference-20130507');

1;
