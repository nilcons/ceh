package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => '2zlbi8dqygwcj2k6rwhxc2md8yhla46p-vboot_reference-20130507');

1;
