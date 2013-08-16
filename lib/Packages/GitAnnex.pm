package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => '1f2ecd08cc28d0d199d7f0304da9d8bbc2ff6239', derivation => 'gq6f3w74gvi90r524pglv8gkm4n0caj4-git-annex-4.20130802.drv', out => 'z9v5zc15rwrgi1j5x16wmlpapw16kcwi-git-annex-4.20130802');

1;
