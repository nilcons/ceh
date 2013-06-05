package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => '0395m72kaplfc4av6a4xas8nywy8ahbx-git-1.8.2.3.drv', out => '3wi6yzg2gdfrj1pcs1jlj1ji538jkhnw-git-1.8.2.3');

1;
