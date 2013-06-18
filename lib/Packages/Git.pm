package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => '9dbr0apnq1ajdy3k2qpv4jzlca33sm5w-git-1.8.2.3.drv', out => 'y14f6zs6sc8qr8kp4fpqfhd58a4lpq4d-git-1.8.2.3');

1;
