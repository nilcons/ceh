package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'ipzwy99h4372nbp3w30gwxwymbcf59d0-git-annex-4.20130815.drv', out => '4fdjyph2w8xsw0qczhlaqcsja2sbs8wa-git-annex-4.20130815');

1;
