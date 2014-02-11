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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '0l64803iqiwnkfgfjbkd9x3grd13l15r-tws-20130211.drv', out => '7v3lzw5if2k3pqacrh5q12fdvhzpifis-tws-20130211');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'w791m88zw73j4vyj9853sn1njc2qq9m5-tws-20130211.drv', out => 'g7kxnwkq9v5kils19mjrym9fmx960b4g-tws-20130211');
}

1;
