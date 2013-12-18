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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '8gc2h3b2304xdk11lx96zzj0jqh6d448-tws-20131218.drv', out => '8382gd4gfivk2jqw0y8rphsbff7crzra-tws-20131218');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'jhqlizflpp9l81wpv2hmhzy83s2akf26-tws-20131218.drv', out => 'xahna0jzbib4rbdmh6l26z9jp3gh596r-tws-20131218');
}

1;
