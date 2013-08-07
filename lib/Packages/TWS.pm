package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => '18xhcw0y3vyv5v3nw2p6a3bg2zszaibf-tws-937.drv', out => 'j5x0iw5ks3zb014q9y95kjl8jvkvdzjf-tws-937');

1;
