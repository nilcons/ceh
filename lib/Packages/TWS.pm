package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => 'm2xqlvi1yd0waq332jvw8979nj59sfzc-tws-20130321');

1;
