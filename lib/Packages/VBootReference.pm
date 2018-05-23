package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'ki38p5ja8y0x91xmn90w4bszwjhh6clb-vboot_reference-20180311');

1;
