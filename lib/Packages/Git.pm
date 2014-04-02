package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '9rkb9bk8ij4cwapb6zsb8cahjpv92wsy-git-1.9.1');

1;
