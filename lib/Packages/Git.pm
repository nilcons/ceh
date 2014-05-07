package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'gxris91jj66l7l85nfj0g0s6rbigkank-git-1.9.2');

1;
