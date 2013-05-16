package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => '008bb6935cddd3708ac4caf3360afb603ee5b4fa', derivation => 'hp0kgnwqfcxrwl54lrb0nkyljnkypih1-git-annex-4.20130405.drv', out => 'ac7yzy5ysdrrqd1nxkz2i28w68xwzvs6-git-annex-4.20130405');

1;
