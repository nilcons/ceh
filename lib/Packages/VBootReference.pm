package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'z2j9ikrvm9mpjdmsgvdhcx0g2pc7wi51-vboot_reference-20130507.drv', out => 'sqs64zcrajkkvxc74dwhx0h4k3q8z2lc-vboot_reference-20130507');

1;
