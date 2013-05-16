package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '008bb6935cddd3708ac4caf3360afb603ee5b4fa', derivation => 'f4716hiczprh8fvh29ivydpsvd5pkr15-git-1.8.2.1.drv', out => 'fh5n63g74dkv921srqb91c7bhw1c9svb-git-1.8.2.1');

1;
