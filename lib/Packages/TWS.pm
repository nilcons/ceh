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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'j80zwrnpy72b104frirmnm744289z0sj-tws-937.drv', out => 'm2lxaszqa0gq7dm54dps2zv4xvq84p44-tws-937');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'b26gd0v68wa3g968ixj6d53686db4a2x-tws-937.drv', out => 'x0m1ibankcsa4asf9sq2x7yqa2sj5pi7-tws-937');
}

1;
