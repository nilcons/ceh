package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'c39k06q6b0a3d28l826zwq38yqfgvchw-vboot_reference-20130507');

1;
