package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '2g0zlzxifmrjx260g15v7bk5067s8snn-git-annex-5.20140129.drv', out => '8b2k4gd7apdjhiwj3fz8a0f3lzcrpars-git-annex-5.20140129');

1;
