package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => 'ihb9npsfymly435jmix2sfjn8830f83z-vboot_reference-20130507.drv', out => '3pjl6ffsmblyy1xpvlrq1y8d1big1w7i-vboot_reference-20130507');

1;
