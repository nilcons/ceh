package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => '75z31cfzxjn765c4lcdpwc8hjb6l2raq-git-annex-4.20130601.drv', out => '0mcy53yxmds31afly529wga7yyz9qifv-git-annex-4.20130601');

1;
