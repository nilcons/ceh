package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '5gpj8cpmhkic49x3mb2bk76yzhpmgmhf-tws-20130403');

1;
