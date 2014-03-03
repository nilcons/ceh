package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'kl5vdv1ak5hygl2plix38cxlv8nmwa17-vboot_reference-20130507.drv', out => '42lnszz9jhs7vp6xfwhmcqh7zfqjzrcy-vboot_reference-20130507');

1;
