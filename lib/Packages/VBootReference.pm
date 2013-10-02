package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '2wr4rzfcc2zxa328nzbhsm31bwqsccj6-vboot_reference-20130507.drv', out => 'qb4m1y4kzs44yjrn7crywyq097vag8cb-vboot_reference-20130507');

1;
