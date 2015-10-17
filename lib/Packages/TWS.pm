package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'rfx2pj8kn8bcwsb8zlx0xbav7laqmbif-tws-20151017');

1;
