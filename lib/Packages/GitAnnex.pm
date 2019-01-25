package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'zsszfz7mjvxp50hh9d5nqf66670lsz88-git-annex-6.20180509');

1;
