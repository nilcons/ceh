package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '2fkgkqbqinyr0izbnzr1jiz038z7gj3s-git-annex-5.20140320');

1;
