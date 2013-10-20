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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '1gvqrfvmmf54pbizs8h5f0l93d43ha91-tws-20131020.drv', out => 'dlvpcdl8b3b9imc19nx9ra3pcvj1126g-tws-20131020');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'za8zich3zpd7lzi4q24phcllrclf99ks-tws-20131020.drv', out => 'gfrcqwgx504rwj3ypphlsxg23kvlqk9y-tws-20131020');
}

1;
