package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'yq1ra3w5d2mj892dksaq7ig8d53gkc2l-tws-20141218');

1;
