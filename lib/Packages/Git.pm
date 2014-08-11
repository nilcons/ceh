package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => '3sc6b2lmwv0yfazzm3vka6abp8xhqriv-git-2.0.2');

1;
