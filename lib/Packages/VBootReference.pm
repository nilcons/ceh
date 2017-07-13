package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => 'sg8lr6iaqn21455l4m94xrzf159c5mbw-vboot_reference-20130507');

1;
