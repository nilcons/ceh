package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
if ($ENV{CEH_TWS64}) {
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => '19np959ajfkkkcfsyn29h31f1qp02vq9-tws-20130920.drv', out => 'y5ajizb7vd9nfzis7ydx2qj89jbldn21-tws-20130920');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => '2xphd83dliln61cnny8i3g527x4hw9h7-tws-20130920.drv', out => 'qpksazw3h3wc9n9v41fpn28lv72s92gm-tws-20130920');
}

1;
