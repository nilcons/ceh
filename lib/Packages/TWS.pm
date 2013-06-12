package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'ar8ximaghjqknfqpb3jyysb1q2mircp6-tws-937.drv', out => 'q9cfhx7ncixcv1vp2dv509xb2bnvb55b-tws-937');

1;
