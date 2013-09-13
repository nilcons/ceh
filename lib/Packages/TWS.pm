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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => '56phsk1rg4mbks3wvrhh22i0dycryq3h-tws-20130912.drv', out => 'aypsgzni4szi6qlk3ngy0rjq2c55yb49-tws-20130912');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'vr8wf54i64wrx8qa9sq7rkacbwv27ay4-tws-20130912.drv', out => 'w1ffj7i06dvk2kiwlad0r2a4365993p6-tws-20130912');
}

1;
