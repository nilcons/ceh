package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'gg7gcwl1yi6a4d79bqfkz719h6vr4bl5-git-annex-5.20141203');

1;
