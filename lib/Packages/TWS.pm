package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => 'vphpd1jyb9a5xrywanakgb7ikwhkfvzi-tws-20170713');

1;
