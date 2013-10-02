package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '693iiaiff6jmnrz4bls80hw06iv527ij-git-1.8.4.drv', out => 'khqvsrpmx8nz6g5vcb9ilfpbb11vxb3w-git-1.8.4');

1;
