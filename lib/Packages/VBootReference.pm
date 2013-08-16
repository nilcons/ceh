package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => '1f2ecd08cc28d0d199d7f0304da9d8bbc2ff6239', derivation => 'z2j9ikrvm9mpjdmsgvdhcx0g2pc7wi51-vboot_reference-20130507.drv', out => 'sqs64zcrajkkvxc74dwhx0h4k3q8z2lc-vboot_reference-20130507');

1;
