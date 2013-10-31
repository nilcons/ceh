package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'lkknh56711ijdiq83ywkf5a6iiydnk8p-git-annex-4.20131002.drv', out => '98ycrmzz7knn5nbn874zn56xdpkp8d6p-git-annex-4.20131002');

1;
