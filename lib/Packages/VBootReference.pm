package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => '74wi1f5gybynbm9nb3vb2vkd02i99aa8-vboot_reference-20130507.drv', out => '42lnszz9jhs7vp6xfwhmcqh7zfqjzrcy-vboot_reference-20130507');

1;
