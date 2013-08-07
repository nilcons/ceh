package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => 'lrksslyp1ks5jbi8mab5alfixs7nfd9g-vboot_reference-20130507.drv', out => 'sqs64zcrajkkvxc74dwhx0h4k3q8z2lc-vboot_reference-20130507');

1;
