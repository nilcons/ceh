package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => 's9kqb3s0rszdj2dm0ibl321irxn8419k-git-2.13.2');

1;
