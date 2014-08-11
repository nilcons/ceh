package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'zjf974731db77z8rbvgbnx832v68a53b-tws-20130809');

1;
