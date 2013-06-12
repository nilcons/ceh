package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => '1dqg4fi1w7pqd0acmddgsc1y1xc7ycrn-tws-937.drv', out => 'd5ya0bbpxih9pjm8c555j05v7rzi5xrf-tws-937');

1;
