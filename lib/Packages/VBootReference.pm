package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '23fhnkmq3c5n29xpp6p66fyv276b2gl1-vboot_reference-20130507');

1;
