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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'ifywkh36kf56qa5fg12ichpw258a5zpk-tws-20130920.drv', out => 'rzxan9qshbmfl0nnkzv2lgdmh2pl9fgv-tws-20130920');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'qscpv450sb4v0jsjya8vwznk02jpkbs2-tws-20130920.drv', out => 'mpf1xinqbga4fmrp64m7md6vss0x75kk-tws-20130920');
}

1;
