package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'q3b53410qwh7cvl6lldayaj7ina2ybr9-tws-937.drv', out => '5ki8amlw4l07xba242w6wrjnj5sj9jfz-tws-937');

1;
