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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'rx8y4d57k4584gclrqi5f352ywapwif7-tws-20131231.drv', out => 'q4nkms782g565cm9za6y3shdlb097kda-tws-20131231');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'vs4zmhi46hg96rakwhnjakb490vji3k5-tws-20131231.drv', out => '5n44sxmp2z1swp2h9d9r0cwghlpwa530-tws-20131231');
}

1;
