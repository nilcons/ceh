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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'lfyqmrkz3vlqmgpw1i73wrvkar6zlyhw-tws-20130207.drv', out => 'r4nmydklzi5yklmdvj7s0bq3159l1zx6-tws-20130207');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'b1gamnbjahxh47iza97hx49f6zv3zxa4-tws-20130207.drv', out => '7mqfrs0d5d2wiviz7nmxv94vd8q798bv-tws-20130207');
}

1;
