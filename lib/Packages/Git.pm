package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'al1klcp63f67jkyxs7w075r8j0c7i9kw-git-2.1.3');

1;
