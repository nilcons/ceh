package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '42lnszz9jhs7vp6xfwhmcqh7zfqjzrcy-vboot_reference-20130507');

1;
