package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'ny1r9ljcqgw5c7q9df6arvw4m5654pyz-vboot_reference-20130507');

1;
