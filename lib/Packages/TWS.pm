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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'vn675nrlkmvhp5sydq8r90nhpqmlapnb-tws-20131109.drv', out => 'piwxdrhg9lg4ixg9hjaq1pka6hbfpqn3-tws-20131109');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '69zh41yar1mnjd81ml39y0bjfqkqng70-tws-20131109.drv', out => 'rfppmmckhz8bgsdn1sx4n03fcs6gbcis-tws-20131109');
}

1;
