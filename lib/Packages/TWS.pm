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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '94m6ggz63vadrlz54m1ivs0zirhs1z1z-tws-20130107.drv', out => 'g8n010d5cgljxrv057mif5x6cfg6r1cr-tws-20130107');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '4nzpmqj2dn7lx4xjqzj9sa32bxh9nxnw-tws-20130107.drv', out => 'sgzwgw4ldav56fr4rski33lsyvbpxm23-tws-20130107');
}

1;
