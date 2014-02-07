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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => 'k5v73chx7g640vnscdk3929hr1iaz157-tws-20130207.drv', out => '2bs84bz5zhlhxvyq2cwzzh0dbr7xazsk-tws-20130207');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => '12g5z0zlai7s4ih47ffqv7g104qx9qrr-tws-20130207.drv', out => '215gxi6p6r4nwzskfspxn7n08w4hy5z7-tws-20130207');
}

1;
