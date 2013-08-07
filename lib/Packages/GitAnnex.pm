package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => 'zaxhpg0w8fkh63v0zhgap3y25lvqg9bm-git-annex-4.20130627.drv', out => 'any4h6hg9b59vmp9nn7yncp86cav4jha-git-annex-4.20130627');

1;
