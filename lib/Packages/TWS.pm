package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'cylb0mil7n1g08h7lh8iyisvyd6svghq-tws-20151015');

1;
