package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => 'lk5w2mbc36cy8q44qx6c7771fi9pyzir-git-annex-4.20130723.drv', out => 'w1nlvy491qqppwz0z45c430dcwx7d0i3-git-annex-4.20130723');

1;
