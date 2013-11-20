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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '1azbxds6gc72g00y585xxpq2v36361my-tws-20131109.drv', out => 'a1idlbkgdvhmvc7adbmb38lib2h8r0fn-tws-20131109');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'wdprs8yb70v4s5cn5yps2fi2qbgzclq7-tws-20131109.drv', out => '601cb9025y6l4w3ybii88j7mm892j8fm-tws-20131109');
}

1;
