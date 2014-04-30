package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'sxrk3dykr4ggf0g2dngvz7pzpr4c9d02-tws-20130430');

1;
