package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'z8d22fj62i8vs607gyzxzqn05bcpl8r2-tws-20130508');

1;
