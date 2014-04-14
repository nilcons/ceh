package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'cfmlbfbjvc0ilhz0c5ansabryx2jpgxs-tws-20130403');

1;
