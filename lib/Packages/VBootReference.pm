package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => 'lj5wipya6zlh7xnb1n4d0k3a2cfa1rbd-vboot_reference-20130507.drv', out => 'sqs64zcrajkkvxc74dwhx0h4k3q8z2lc-vboot_reference-20130507');

1;
