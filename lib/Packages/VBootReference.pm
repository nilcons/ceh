package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'ny1r9ljcqgw5c7q9df6arvw4m5654pyz-vboot_reference-20130507');

1;
