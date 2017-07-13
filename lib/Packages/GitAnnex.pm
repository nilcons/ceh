package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => 'hsricsyzcfxdz2bqgqh9x2m3h6ciabdw-git-annex-6.20170520');

1;
