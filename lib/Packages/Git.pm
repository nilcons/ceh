package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => '5p7y2zikzl1a30fi4djmhkgamqqhkmd0-git-2.16.3');

1;
