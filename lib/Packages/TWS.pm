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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'mdb2kcja3m7jr4pjyap168fw9p1dh1vc-tws-20131020.drv', out => 'mj6yimpi3m52ha6cpibay90ni649f079-tws-20131020');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'dz0sl2hpmvwj7d3h60jl02zi1zq4rc07-tws-20131020.drv', out => 'xyn7c95x0v3rsw3lyhw6c9zn57sqaswr-tws-20131020');
}

1;
