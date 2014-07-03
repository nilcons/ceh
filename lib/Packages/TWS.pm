package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'zaw27ipxagxsiv4d3b58h9z03d2mh8pj-tws-20130703');

1;
