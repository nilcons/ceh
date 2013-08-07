package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => '8fj1fwkj660j5nd7gi9d0365z0vhdm4z-git-1.8.2.3.drv', out => 'sabpq3dmwwf6z27kh1m41iajcn7zc0il-git-1.8.2.3');

1;
