package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'j7l5dwxzwkj4qd9363nfv748xj218mkn-tws-20150217');

1;
